import UIKit
import SnapKit

final class BannerCollectionViewCell: UICollectionViewCell {

    static let identifier = "BannerCollectionViewCell"

    // MARK: - UI Elements

    private let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Configure

    func configure(imageName: String) {
        bannerImageView.image = UIImage(named: imageName)
    }
}
