import UIKit
import SnapKit

final class BannerCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: BannerCollectionViewCell.self)

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
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Setup
    
    private func setupUI() {
        contentView.addSubview(bannerImageView)
    }

    private func setupConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Configure

    func configure(imageName: String) {
        bannerImageView.image = UIImage(named: imageName)
    }
}
