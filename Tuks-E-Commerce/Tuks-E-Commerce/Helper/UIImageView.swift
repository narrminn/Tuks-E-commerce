import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(fullURL: String) {
        guard let url = URL(string: fullURL) else { return }
        self.kf.setImage(with: url)
    }
    
    func loadImage(url: String) {
        let fullPath = "http://ecommerce.narminlt.beget.tech" + url
        guard let url = URL(string: fullPath) else { return }
        self.kf.setImage(with: url)
    }
}
