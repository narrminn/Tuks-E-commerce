import Foundation

struct RegisterResponse: Codable {
    let message: String?
    let data: RegisterResponseData?
}

struct RegisterResponseData: Codable {
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
    }
}
