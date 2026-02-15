import Foundation

struct LoginResponse: Codable {
    let message: String?
    let data: LoginResponseData?
}

struct LoginResponseData: Codable {
    let token: String?
    let user: LoginResponseUser?
}

struct LoginResponseUser: Codable {
    let id: Int?
    let name, surname, email: String?
    let profilePhotoPath, profilePhotoUUID, phone, birth: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, surname, email
        case profilePhotoPath = "profile_photo_path"
        case profilePhotoUUID = "profile_photo_uuid"
        case phone, birth
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

