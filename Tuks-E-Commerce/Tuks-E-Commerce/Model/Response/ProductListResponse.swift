import Foundation

struct ProductListResponse: Codable {
    let message: String?
    let data: ProductListData?
    let meta: Meta?
}

struct ProductListData: Codable {
    let products: [Product]?
}

struct Product: Codable, ProductProtocol {
    let id: Int
    let name, companyName: String
    let price: Double
    let mainPhoto: String
    let isWishlist: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case companyName = "company_name"
        case price
        case mainPhoto = "main_photo"
        case isWishlist = "is_wishlist"
    }
}

