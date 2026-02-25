import Foundation

struct ProfileUpdateRequest: Codable {
    let name, surname, phone, birth: String?
    let profilePhoto: ProfilePhoto?

    enum CodingKeys: String, CodingKey {
        case name, surname, phone, birth
        case profilePhoto = "profile_photo"
    }
}

struct ProfilePhoto: Codable {
    let fileUUID, filePath: String?

    enum CodingKeys: String, CodingKey {
        case fileUUID = "file_uuid"
        case filePath = "file_path"
    }
}
