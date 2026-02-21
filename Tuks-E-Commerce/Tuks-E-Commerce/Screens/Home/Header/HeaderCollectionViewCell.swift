import UIKit
import SnapKit

final class HeaderCollectionViewCell: UICollectionViewCell {

    static let identifier = "HeaderCollectionViewCell"

    var onSearchTapped: (() -> Void)?

    // MARK: - UI Elements

    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let searchView = CustomSearchView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        searchView.onSearchTapped = { [weak self] in
            self?.onSearchTapped?()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup

    private func addSubviews() {
        contentView.addSubview(greetingLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(searchView)
    }

    private func setupConstraints() {

        greetingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(20)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingLabel.snp.bottom).offset(2)
            make.leading.equalTo(greetingLabel)
        }

        searchView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-16)
        }
    }

    // MARK: - Configure

    func configure(greeting: String, name: String) {
        greetingLabel.text = greeting
        nameLabel.text = name
    }
}
