import UIKit
import SnapKit

final class BrandCollectionViewCell: UICollectionViewCell {

    static let identifier = "BrandCollectionViewCell"

    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 28
        view.clipsToBounds = true
        return view
    }()

    private let brandImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(brandImageView)
        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(56)
        }

        brandImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(28)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }

    // MARK: - Configure

    func configure(with brand: Company) {
        nameLabel.text = brand.name
        if let companyLogo = brand.logo {
            brandImageView.loadImage(fullURL: companyLogo)
        }
    }
}
