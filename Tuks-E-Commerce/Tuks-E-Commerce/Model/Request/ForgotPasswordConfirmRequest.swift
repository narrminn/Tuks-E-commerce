import Foundation

struct ForgotPasswordConfirmRequest: Encodable {
    let email: String
    let code: String
    let password: String
}
