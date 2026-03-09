import UIKit
import SnapKit

protocol BagItemCellDelegate: AnyObject {
    func bagItemCellDidTapMore(basketId: Int)
}

final class BagItemTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: BagItemTableViewCell.self)
    
    // MARK: - Properties
    
    weak var delegate: BagItemCellDelegate?
    private var basketId: Int = 0
    
    // MARK: - UI Elements
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    private let brandLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13, weight: .semibold)
        lbl.textColor = .darkGray
        return lbl
    }()
    
    private let verifiedIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "checkmark.seal.fill"))
        iv.tintColor = UIColor(red: 0.29, green: 0.36, blue: 0.96, alpha: 1.0)
        return iv
    }()
    
    private let brandStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 4
        sv.alignment = .center
        return sv
    }()
    
    private let infoStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 4
        return sv
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .label
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let sizeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = .gray
        return lbl
    }()
    
    private lazy var moreButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.tintColor = .darkGray
        btn.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        return btn
    }()
    
    private let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = .label
        lbl.textAlignment = .right
        return lbl
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        [
            brandLabel,
            verifiedIcon
        ].forEach { brandStack.addArrangedSubview($0) }
        
        [
            nameLabel,
            sizeLabel
        ].forEach { infoStack.addArrangedSubview($0) }
        
        [
            productImageView,
            brandStack,
            moreButton,
            infoStack,
            priceLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        verifiedIcon.snp.makeConstraints { make in
            make.size.equalTo(14)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(70)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }
        
        brandStack.snp.makeConstraints { make in
            make.top.equalTo(productImageView)
            make.leading.equalTo(productImageView.snp.trailing).offset(12)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(brandStack)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(24)
        }
        
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(brandStack.snp.bottom).offset(8)
            make.leading.equalTo(brandStack)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }

        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(infoStack)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(infoStack.snp.trailing).offset(8)
        }
    }
    
    // MARK: - Configure
    
    func configure(item: BasketItem) {
        self.basketId = item.basketID ?? 0
        brandLabel.text = item.company
        nameLabel.text = item.name
        sizeLabel.text = "Size: \(item.attributes ?? "")"
        priceLabel.text = "$\(item.lineTotal ?? 0)"
        verifiedIcon.isHidden = false
        productImageView.loadImage(fullURL: item.image ?? "")
    }
    
    // MARK: - Actions
    
    @objc private func moreTapped() {
        delegate?.bagItemCellDidTapMore(basketId: basketId)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        brandLabel.text = nil
        nameLabel.text = nil
        sizeLabel.text = nil
        priceLabel.text = nil
        delegate = nil
        basketId = 0
    }
}
