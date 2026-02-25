import Foundation

enum ProductEndPoint {
    case getPopularProduct(page: Int)
    case addWishlist(id: Int)
    case getWishlist(page: Int)
}

extension ProductEndPoint: Endpoint {
    var baseURL: String {
        return "http://ecommerce.narminlt.beget.tech"
    }

    var path: String {
        switch self {
        case .getPopularProduct:
            return "/api/product/popular"
        case .addWishlist(let id):
            return "/api/product/wishlist/update/\(id)"
        case .getWishlist:
            return "/api/product/wishlist/index"
        }
    }

    var method: HttpMethod {
        switch self {
        case .getPopularProduct:
            return .get
        case .addWishlist:
            return .post
        case .getWishlist:
            return .get
        }
    }

    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Accept-Language": "en",
            "Authorization": "Bearer \(KeychainManager.shared.retrieve(key: "token") ?? "")"
        ]
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .getPopularProduct(let page), .getWishlist(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)")
            ]
        default:
            return nil
        }
    }

    var httpBody: (any Encodable)? {
        return nil
    }
}
