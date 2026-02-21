import Foundation

enum HomeSection: Int, CaseIterable {
    case brands
    case banner
    case products

    var title: String? {
        switch self {
        case .brands:   
            return "Popular Brand"
        case .products: 
            return "Popular"
        default:
            return nil
        }
    }
}
