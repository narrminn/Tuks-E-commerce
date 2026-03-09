import UIKit
import SnapKit

final class EmptyStateView: UIView {
    
    // MARK: - UI Elements
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
        view.layer.cornerRadius = 75
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .systemBlue
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    init(icon: UIImage?, iconTintColor: UIColor = .systemBlue, title: String, description: String) {
        super.init(frame: .zero)
        iconImageView.image = icon
        iconImageView.tintColor = iconTintColor
        titleLabel.text = title
        descriptionLabel.text = description
        isHidden = true
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Setup
    
    private func setupUI() {
        containerView.addSubview(iconImageView)
        [containerView, titleLabel, descriptionLabel].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extension

extension EmptyStateView {
    static func wishlist() -> EmptyStateView {
        EmptyStateView(
            icon: UIImage(systemName: "heart.fill"),
            iconTintColor: .systemPink,
            title: "Wishlist is Empty",
            description: "Tap the heart on items you love and they'll appear here for easy access later."
        )
    }
    
    static func cart() -> EmptyStateView {
        EmptyStateView(
            icon: UIImage(systemName: "bag.fill"),
            iconTintColor: UIColor(red: 0.27, green: 0.38, blue: 0.9, alpha: 1),
            title: "Your Cart is Empty",
            description: "Browse our collection and add something special to your bag."
        )
    }
    
    static func searchNotFound() -> EmptyStateView {
        EmptyStateView(
            icon: UIImage(systemName: "magnifyingglass"),
            iconTintColor: .gray,
            title: "No Results Found",
            description: "We couldn't find any products matching your search. Try a different keyword."
        )
    }
}
