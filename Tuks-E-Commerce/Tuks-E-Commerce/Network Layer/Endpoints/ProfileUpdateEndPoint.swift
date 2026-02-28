import Foundation

enum ProfileUpdateEndPoint {
    case updateProfile(body: ProfileUpdateRequest)
}

extension ProfileUpdateEndPoint: Endpoint {
    var baseURL: String {
        return "http://ecommerce.narminlt.beget.tech"
    }

    var path: String {
        switch self {
        case .updateProfile(let body):
            return "/api/profile/me/update"
        }
    }

    var method: HttpMethod {
        switch self {
        case .updateProfile:
            return .post
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
        return nil
    }

    var httpBody: (any Encodable)? {
        switch self {
        case .updateProfile(let body):
            return body
        }
    }
}
