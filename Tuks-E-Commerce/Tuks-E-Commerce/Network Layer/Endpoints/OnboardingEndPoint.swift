import Foundation

enum OnboardingEndPoint {
    case register(body: RegisterRequest)
    case registerApprove(userId: Int, body: RegisterApproveRequest)
}

extension OnboardingEndPoint: Endpoint {
    var baseURL: String {
        return "http://ecommerce.narminlt.beget.tech"
    }

    var path: String {
        switch self {
        case .register:
            return "/api/register"
        case .registerApprove(let userId, let body):
            return "/api/register/approve/\(userId)"
        }
    }

    var method: HttpMethod {
        switch self {
        case .register, .registerApprove:
            return .post
        }
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Accept-Language": "en"
        ]
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var httpBody: (any Encodable)? {
        switch self {
        case .register(let body):
            return body
        case .registerApprove(let userId, let body):
            return body
        }
    }
}
