import Foundation

enum Icon {
    case heart
    case heartFilled
    
    var title: String {
        switch self {
        case .heart:
            return "heart"
        case .heartFilled:
            return "heart.fill"
        }
    }
}
