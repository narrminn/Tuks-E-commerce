import Foundation

struct FileUploadResponse: Codable {
    let message: String?
    let data: FileUploadData?
}

struct FileUploadData: Codable {
    let file: File?
}

struct File: Codable {
    let storagePath, path, fileExtension: String?
    let size: Int?
    let mimeType, id, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case storagePath = "storage_path"
        case path
        case fileExtension = "extension"
        case size
        case mimeType = "mime_type"
        case id
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
