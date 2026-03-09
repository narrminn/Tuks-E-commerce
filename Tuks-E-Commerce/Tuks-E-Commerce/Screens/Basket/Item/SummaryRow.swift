import UIKit
import SnapKit

final class SummaryRow: UIView {
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    init(title: String, defaultValue: String = "$0.00", isBold: Bool = false) {
        super.init(frame: .zero)
        configureLabels(title: title, defaultValue: defaultValue, isBold: isBold)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setValue(_ text: String) {
        valueLabel.text = text
    }
    
    private func configureLabels(title: String, defaultValue: String, isBold: Bool) {
        titleLabel.text = title
        titleLabel.font = isBold ? .systemFont(ofSize: 16, weight: .bold) : .systemFont(ofSize: 14)
        titleLabel.textColor = isBold ? .black : .gray
        
        valueLabel.text = defaultValue
        valueLabel.font = isBold ? .systemFont(ofSize: 16, weight: .bold) : .systemFont(ofSize: 14, weight: .medium)
        valueLabel.textAlignment = .right
    }
    
    private func setupUI() {
        [titleLabel, valueLabel].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        valueLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8)
        }
    }
}
