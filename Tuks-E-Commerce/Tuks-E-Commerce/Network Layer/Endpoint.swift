import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var httpBody: Encodable? { get }
    var multipartData: MultipartData? { get }
}

extension Endpoint {
    var multipartData: MultipartData? { nil }
}

extension Endpoint {
    func makeRequest() -> Result<URLRequest, NetworkError> {
        guard var components = URLComponents(string: baseURL) else {
            return .failure(.invalidURL)
        }
        
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let multipart = multipartData {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = buildMultipartBody(multipart: multipart, boundary: boundary)
        } else if let httpBody {
            do {
                let encodedData = try JSONEncoder().encode(httpBody)
                request.httpBody = encodedData
            } catch {
                return .failure(.encodingError)
            }
        }
        
        return .success(request)
    }
}

private func buildMultipartBody(multipart: MultipartData, boundary: String) -> Data {
    var body = Data()
    
    body.append("--\(boundary)\r\n")
    body.append("Content-Disposition: form-data; name=\"\(multipart.fieldName)\"; filename=\"\(multipart.fileName)\"\r\n")
    body.append("Content-Type: \(multipart.mimeType)\r\n\r\n")
    body.append(multipart.fileData)
    body.append("\r\n--\(boundary)--\r\n")
    
    return body
}

// Data extension - string append üçün
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
