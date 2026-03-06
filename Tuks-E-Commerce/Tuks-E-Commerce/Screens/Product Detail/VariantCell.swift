import UIKit
import SnapKit

final class VariantCell: UICollectionViewCell {
    static let reuseID = "VariantCell"

    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = false
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1.5
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14))
        }
    }

    required init?(coder: NSCoder) { fatalError() }
    
    
    func configure(value: Value, isSelected: Bool, isAvailable: Bool = true) {
        titleLabel.text = value.value

        if !isAvailable {
            titleLabel.textColor = .lightGray
            contentView.backgroundColor = .white
            contentView.layer.borderColor = UIColor.systemGray5.cgColor
        } else {
            titleLabel.textColor = isSelected ? .white : .black
            contentView.backgroundColor = isSelected
                ? UIColor(red: 0.27, green: 0.38, blue: 0.9, alpha: 1) : .white
            contentView.layer.borderColor = isSelected
                ? UIColor.systemBlue.cgColor : UIColor.systemGray4.cgColor
        }
    }
}
