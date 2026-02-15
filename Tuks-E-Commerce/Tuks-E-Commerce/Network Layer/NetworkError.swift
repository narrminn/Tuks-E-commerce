import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case encodingError
    case serverError(statusCode: Int)
    case serverMessage(String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Yanlış URL"
        case .noData:
            return "Məlumat tapılmadı"
        case .decodingError:
            return "Decode xətası"
        case .encodingError:
            return "Encode xətası"
        case .serverError(let statusCode):
            return "Server xətası: \(statusCode)"
        case .serverMessage(let message):
            return message
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
