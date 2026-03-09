import UIKit
import SnapKit

final class ThumbnailCell: UICollectionViewCell {
    
    static let reuseID = String(describing: ThumbnailCell.self)

    //MARK: - UI Elements
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()

    private let overlayLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        lbl.layer.cornerRadius = 10
        lbl.clipsToBounds = true
        lbl.isHidden = true
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
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.clear.cgColor
        
        [imageView, overlayLabel].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        overlayLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(imageUrl: String, isSelected: Bool, isLast: Bool, remaining: Int) {
        contentView.layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor

        imageView.loadImage(fullURL: imageUrl)

        overlayLabel.isHidden = !(isLast && remaining > 0)
        overlayLabel.text = "+\(remaining)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        overlayLabel.isHidden = true
        overlayLabel.text = nil
        contentView.layer.borderColor = UIColor.clear.cgColor
    }
}
