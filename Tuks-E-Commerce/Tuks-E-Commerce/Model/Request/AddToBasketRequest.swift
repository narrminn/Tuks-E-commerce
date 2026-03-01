import Foundation

struct AddToBasketRequest: Encodable {
    let variantID, quantity: Int?

    enum CodingKeys: String, CodingKey {
        case variantID = "variant_id"
        case quantity
    }
}
