import Foundation

enum OnboardingEndPoint {
    case register(body: RegisterRequest)
    case registerApprove(userId: Int, body: RegisterApproveRequest)
    
    case forgotPassword(body: ForgotPasswordRequest)
    case forgotPasswordConfirm(body: ForgotPasswordConfirmRequest)
    
    case login(body: LoginRequest)
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
        case .forgotPasswordConfirm(_):
            return "/api/forgot-password/confirm"
        case .login(let body):
            return "/api/login"
        }
    }

    var method: HttpMethod {
        switch self {
        case .register, .registerApprove, .forgotPassword, .forgotPasswordConfirm, .login:
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
        case .login(let body):
            return body
        }
    }
}
