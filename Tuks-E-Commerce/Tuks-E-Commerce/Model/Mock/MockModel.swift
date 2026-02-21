import Foundation

struct BrandModel {
    let id: Int
    let name: String
    let imageName: String
}

struct ProductModel {
    let id: Int
    let name: String
    let brandName: String
    let price: Double
    let imageName: String
    var isFavorite: Bool
    let isVerified: Bool

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }
}
