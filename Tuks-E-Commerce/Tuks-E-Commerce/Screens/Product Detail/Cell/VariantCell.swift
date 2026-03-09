import UIKit
import SnapKit

final class VariantCell: UICollectionViewCell {
    
    static let reuseID = String(describing: VariantCell.self)

    //MARK: - UI Elements

    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        return lbl
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }
    
    //MARK: - Setup
    
    private func setupUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.5
        contentView.addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14))
        }
    }
    
    
    func configure(value: Value, isSelected: Bool, isAvailable: Bool = true) {
        titleLabel.text = value.value

        guard isAvailable else {
            titleLabel.textColor = .lightGray
            contentView.backgroundColor = .white
            contentView.layer.borderColor = UIColor.systemGray5.cgColor
            return
        }

        titleLabel.textColor = isSelected ? .white : .black
        contentView.backgroundColor = isSelected ? UIColor(red: 0.27, green: 0.38, blue: 0.9, alpha: 1) : .white
        contentView.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.systemGray4.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
