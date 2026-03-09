import UIKit

final class SocialIconView: UIImageView {
    init(named: String) {
        super.init(frame: .zero)
        image = UIImage(named: named)
        contentMode = .scaleAspectFit
        clipsToBounds = true
    }
    required init?(coder: NSCoder) { fatalError() }
}
