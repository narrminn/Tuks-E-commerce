import Foundation

enum SortBy: String, CaseIterable {
    case lowestPrice  = "lowest_price"
    case highestPrice = "highest_price"
    case newest       = "newest"
    case aToZ         = "a_z"
    case mostPopular  = "most_popular"
    case mostSuitable = "most_suitable"

    var displayName: String {
        switch self {
        case .lowestPrice:  return "Lowest Price"
        case .highestPrice: return "Highest Price"
        case .newest:       return "Newest"
        case .aToZ:         return "A-Z"
        case .mostPopular:  return "Most Popular"
        case .mostSuitable: return "Most Suitable"
        }
    }
}
