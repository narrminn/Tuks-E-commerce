import Foundation

enum CompanyEndPoint {
    case getCompany
}

extension CompanyEndPoint: Endpoint {
    var baseURL: String {
        return "http://ecommerce.narminlt.beget.tech"
    }

    var path: String {
        switch self {
        case .getCompany:
            return "/api/company/index"
        }
    }

    var method: HttpMethod {
        switch self {
        case .getCompany:
            return .get
            
        }
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Accept-Language": "en",
            "Authorization": "Bearer \(KeychainManager.shared.retrieve(key: "token") ?? "")"
        ]
    }

    var queryItems: [URLQueryItem]? {
        return []
    }

    var httpBody: (any Encodable)? {
        return nil
    }
}
