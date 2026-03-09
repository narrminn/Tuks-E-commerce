import UIKit

final class SocialContainerView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        layer.cornerRadius = 12
    }
    required init?(coder: NSCoder) { fatalError() }
}
