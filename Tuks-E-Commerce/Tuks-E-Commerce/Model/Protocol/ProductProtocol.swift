import Foundation

protocol ProductProtocol {
    var id: Int { get }
    var name: String { get }
    var companyName: String { get }
    var price: Double { get }
    var mainPhoto: String { get }
    var isWishlist: Bool { get }
}
