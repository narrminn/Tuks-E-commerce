import Foundation

struct BasketResponse: Codable {
    let message: String?
    let data: BasketResponseData?
}

struct BasketResponseData: Codable {
    let totalPrice, itemsCount: Int?
    let items: [BasketItem]?

    enum CodingKeys: String, CodingKey {
        case totalPrice = "total_price"
        case itemsCount = "items_count"
        case items
    }
}

struct BasketItem: Codable {
    let basketID, productID, variantID: Int?
    let company, name: String?
    let image: String?
    let attributes, sku: String?
    let price, quantity, lineTotal: Int?

    enum CodingKeys: String, CodingKey {
        case basketID = "basket_id"
        case productID = "product_id"
        case variantID = "variant_id"
        case company, name, image, attributes, sku, price, quantity
        case lineTotal = "line_total"
    }
}
