import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(url: String) {
        let fullPath = "write_basepath" + url
        guard let url = URL(string: fullPath) else { return }
        self.kf.setImage(with: url)
    }
}
