import Foundation

struct MockData {

    static let brands: [BrandModel] = [
        BrandModel(id: 0, name: "Nike", imageName: "nike_logo"),
        BrandModel(id: 0, name: "Nike", imageName: "nike_logo"),
        BrandModel(id: 1, name: "Adidas", imageName: "adidas_logo"),
        BrandModel(id: 1, name: "Adidas", imageName: "adidas_logo"),
        BrandModel(id: 2, name: "Puma", imageName: "puma_logo"),
        BrandModel(id: 2, name: "Puma", imageName: "puma_logo"),
        BrandModel(id: 3, name: "Apple", imageName: "apple_logo"),
        BrandModel(id: 3, name: "Apple", imageName: "apple_logo"),
    ]

    static let bannerImages: [String] = [
        "banner_1",
        "banner_2",
        "banner_3"
    ]

    static let products: [ProductModel] = [
        ProductModel(
            id: 0,
            name: "Nike Offcourt",
            brandName: "NIKE",
            price: 36.21,
            imageName: "product_nike_slide",
            isFavorite: true,
            isVerified: true
        ),
        ProductModel(
            id: 1,
            name: "PREMIUM ESSENTIALS CRINKLE NYLON...",
            brandName: "Adidas",
            price: 146.99,
            imageName: "product_adidas_jacket",
            isFavorite: false,
            isVerified: true
        ),
        ProductModel(
            id: 2,
            name: "Jeans Straight Fit",
            brandName: "ZARA",
            price: 38.17,
            imageName: "product_zara_jeans",
            isFavorite: false,
            isVerified: true
        ),
        ProductModel(
            id: 3,
            name: "Padded VEST",
            brandName: "ZARA",
            price: 69.93,
            imageName: "product_zara_vest",
            isFavorite: true,
            isVerified: true
        )
    ]
}
