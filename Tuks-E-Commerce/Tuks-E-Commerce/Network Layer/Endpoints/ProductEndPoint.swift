import Foundation

enum ProductEndPoint {
    case getPopularProduct(page: Int)
    case addWishlist(id: Int)
    case getWishlist(page: Int)
    case search(page: Int, keyword: String)
    
    case detail(id: Int)
    
    case addToBasket(body: AddToBasketRequest)
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
        case .search:
            return "/api/product/search"
        case .detail(let id):
            return "/api/product/detail/\(id)"
        case .addToBasket:
            return "/api/basket/store"
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
        case .search:
            return .get
        case .detail:
            return .get
        case .addToBasket:
            return .post
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
        case .search(let page, let keyword):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "keyword", value: "\(keyword)")
            ]
        default:
            return nil
        }
    }

    var httpBody: (any Encodable)? {
        switch self {
        case .addToBasket(let body):
            return body
        default:
            return nil
        }
    }
}
