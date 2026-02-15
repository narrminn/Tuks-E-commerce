import Foundation

struct RegisterRequest: Encodable {
    let email: String
    let name: String
    let surname: String
    let phone: String
    let password: String
}
