import Foundation

enum FileUploadEndPoint {
    case fileUpload(data: Data)
}

extension FileUploadEndPoint: Endpoint {
    var baseURL: String {
        return "http://ecommerce.narminlt.beget.tech"
    }

    var path: String {
        switch self {
        case .fileUpload:
            return "/api/file/upload"
        }
    }

    var method: HttpMethod {
        switch self {
        case .fileUpload:
            return .post
        }
    }

    var headers: [String : String]? {
        return [
            "Accept-Language": "en",
            "Authorization": "Bearer \(KeychainManager.shared.retrieve(key: "token") ?? "")"
        ]
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var httpBody: (any Encodable)? {
        return nil
    }
    
    var multipartData: MultipartData? {
        switch self {
        case .fileUpload(let data):
            return MultipartData(
                fileData: data,
                fileName: "photo.jpg",
                mimeType: "image/jpeg",
                fieldName: "file"
            )
        }
    }
}
