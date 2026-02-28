import Foundation

struct ProductDetailResponse: Codable {
    let message: String?
    let data: ProductDetailData?
}

struct ProductDetailData: Codable {
    let product: ProductDetail?
}

struct ProductDetail: Codable {
    let id: Int?
    let name, description: String?
    let price: Int?
    let isWishlist: Bool?
    let rating: Int?
    let company: ProductDetailCompany?
    let images: [Image]?
    let options: [Option]?
    let variants: [Variant]?

    enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case isWishlist = "is_wishlist"
        case rating, company, images, options, variants
    }
}

struct ProductDetailCompany: Codable {
    let name: String?
    let logo: String?
}

struct Image: Codable {
    let id: Int?
    let url: String?
    let isMain: Bool?

    enum CodingKeys: String, CodingKey {
        case id, url
        case isMain = "is_main"
    }
}

struct Option: Codable {
    let name, code: String?
    let values: [Value]?
}

struct Value: Codable {
    let id: Int?
    let value: String?
}

struct Variant: Codable {
    let id: Int?
    let sku: String?
    let price, stock: Int?
    let inStock: Bool?
    let attributes: [Int]?
    let selectionMap: SelectionMap?

    enum CodingKeys: String, CodingKey {
        case id, sku, price, stock
        case inStock = "in_stock"
        case attributes
        case selectionMap = "selection_map"
    }
}

struct SelectionMap: Codable {
    let color, size: Int?
}
