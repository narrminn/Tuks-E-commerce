import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

private extension URLRequest {
    func log() {
        print("🚀 ---- REQUEST START ----")
        print("URL: \(url?.absoluteString ?? "nil")")
        print("Method: \(httpMethod ?? "nil")")
        print("Headers: \(allHTTPHeaderFields ?? [:])")
        if let body = httpBody, let str = String(data: body, encoding: .utf8) {
            print("Body: \(str)")
        }
        print("🚀 ---- REQUEST END ----")
    }
}

final class DefaultNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = endpoint.makeRequest()
        
        switch request {
        case .success(let urlRequest):
            
            do {
                urlRequest.log()
                let (data, response) = try await session.data(for: urlRequest)
                
                if let str = String(data: data, encoding: .utf8) {
                    print("📩 Response: \(str)")
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    
                    guard (200...299).contains(statusCode) else {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            throw NetworkError.serverMessage(errorResponse.message ?? "Error occured in server")
                        }
                        throw NetworkError.serverError(statusCode: statusCode)
                    }
                }
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw NetworkError.decodingError
                }
                
            } catch {
                throw error
            }
            
        case .failure(let error):
            throw error
        }
    }
}
