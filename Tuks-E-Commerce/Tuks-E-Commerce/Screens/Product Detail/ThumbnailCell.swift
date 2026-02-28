import UIKit
import SnapKit

final class ThumbnailCell: UICollectionViewCell {
    static let reuseID = "ThumbnailCell"

    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor(white: 0.95, alpha: 1)
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()

    private lazy var overlayLabel: UILabel = {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.addSubview(imageView)
        contentView.addSubview(overlayLabel)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        overlayLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(imageUrl: String, isSelected: Bool, isLast: Bool, remaining: Int) {
            contentView.layer.borderColor = isSelected
                ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor

        imageView.loadImage(fullURL: imageUrl)

            if isLast && remaining > 0 {
                overlayLabel.text = "+\(remaining)"
                overlayLabel.isHidden = false
            } else {
                overlayLabel.isHidden = true
            }
        }
}
