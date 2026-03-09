import UIKit
import SnapKit

final class ProductCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: ProductCollectionViewCell.self)

    var onFavoriteTapped: (() -> Void)?
    var isWishList = false

    // MARK: - UI Elements

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let favoriteContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private let brandStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.alignment = .center
        return stack
    }()

    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    private let verifiedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.seal.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        containerView.addSubview(productImageView)
        favoriteContainerView.addSubview(favoriteButton)
        containerView.addSubview(favoriteContainerView)

        [
            brandLabel,
            verifiedIcon
        ].forEach { brandStackView.addArrangedSubview($0) }
        
        [
            containerView,
            nameLabel,
            brandStackView,
            priceLabel
        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {

        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.width).multipliedBy(1.1)
        }

        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }

        favoriteContainerView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(32)
        }

        favoriteButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }

        brandStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(12)
        }

        verifiedIcon.snp.makeConstraints { make in
            make.size.equalTo(14)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(brandStackView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(12)
            make.bottom.lessThanOrEqualToSuperview().inset(12)
        }
    }
    
    // MARK: - Actions

    @objc private func favoriteTapped() {
        onFavoriteTapped?()
        
        self.isWishList = !isWishList
        setWishListImage()
    }

    // MARK: - Configure

    func configure(with product: ProductProtocol) {
        nameLabel.text = product.name
        brandLabel.text = product.companyName
        priceLabel.text = "$\(product.price)"
        verifiedIcon.isHidden = false
        
        productImageView.loadImage(fullURL: product.mainPhoto)
        
        self.isWishList = product.isWishlist

        setWishListImage()
    }
    
    func setWishListImage() {
        let heartName = isWishList ? Icon.heartFilled.title : Icon.heart.title
        let heartColor: UIColor = isWishList ? .systemRed : .gray
        favoriteButton.setImage(UIImage(systemName: heartName), for: .normal)
        favoriteButton.tintColor = heartColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        nameLabel.text = nil
        brandLabel.text = nil
        priceLabel.text = nil
        isWishList = false
        onFavoriteTapped = nil
        setWishListImage()
    }
}
