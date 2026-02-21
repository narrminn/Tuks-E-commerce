import UIKit
import SnapKit

final class TabBarItemView: UIView {

    var onTap: (() -> Void)?

    private let icon: String
    private let filledIcon: String
    private let selectedColor = UIColor(red: 154/255, green: 150/255, blue: 138/255, alpha: 1.0)

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGray
        return label
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        return stack
    }()

    init(title: String, icon: String, filledIcon: String) {
        self.icon = icon
        self.filledIcon = filledIcon
        super.init(frame: .zero)

        titleLabel.text = title
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        iconView.image = UIImage(systemName: icon, withConfiguration: config)

        setupUI()
        setupConstraints()
        setupGesture()
        setSelected(false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
    }

    private func setupConstraints() {
        iconView.snp.makeConstraints { make in
            make.size.equalTo(28)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    func setSelected(_ selected: Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        let color: UIColor = selected ? selectedColor : .systemGray
        let iconName = selected ? filledIcon : icon

        iconView.image = UIImage(systemName: iconName, withConfiguration: config)
        iconView.tintColor = color
        titleLabel.textColor = color
    }

    @objc private func tapped() {
        onTap?()
    }
}
