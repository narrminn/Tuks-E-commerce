import Foundation

enum OnboardingEndPoint {
    case register(body: RegisterRequest)
    case registerApprove(userId: Int, body: RegisterApproveRequest)
    
    case forgotPassword(body: ForgotPasswordRequest)
    case forgotPasswordConfirm(body: ForgotPasswordConfirmRequest)
}

extension OnboardingEndPoint: Endpoint {
    var baseURL: String {
        return "http://ecommerce.narminlt.beget.tech"
    }

    var path: String {
        switch self {
        case .register:
            return "/api/register"
        case .registerApprove(let userId, _):
            return "/api/register/approve/\(userId)"
        case .forgotPassword(_):
            return "/api/forgot-password"
        case .forgotPasswordConfirm(let body):
            return "/api/forgot-password/confirm"
        }
    }

    var method: HttpMethod {
        switch self {
        case .register, .registerApprove, .forgotPassword, .forgotPasswordConfirm:
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
        case .registerApprove(_, let body):
            return body
        case .forgotPassword(let body):
            return body
        case .forgotPasswordConfirm(let body):
            return body
        }
    }
}
