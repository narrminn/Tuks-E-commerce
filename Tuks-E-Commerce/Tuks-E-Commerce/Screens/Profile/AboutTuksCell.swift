import UIKit
import SnapKit

final class AboutTuksCell: UITableViewCell {
    
    static let identifier = String(describing: AboutTuksCell.self)
    
    //MARK: - UI Elements
    
    private let iconBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 75/255, green: 104/255, blue: 255/255, alpha: 0.12)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    //MARK: - Setup
    
    private func setupUI() {
        iconBackground.addSubview(iconView)
        [iconBackground, titleLabel].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        iconBackground.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }
        
        iconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconBackground.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func configure(icon: String, title: String) {
        iconView.image = UIImage(named: icon)
        titleLabel.text = title
    }
}
