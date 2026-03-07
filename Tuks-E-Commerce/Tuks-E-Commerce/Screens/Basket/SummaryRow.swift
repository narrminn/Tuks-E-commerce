import UIKit
import SnapKit

final class SummaryRow: UIView {
    
    private let valueLabel = UILabel()
    
    init(title: String, defaultValue: String = "$0.00", isBold: Bool = false) {
        super.init(frame: .zero)
        
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = isBold ? .systemFont(ofSize: 16, weight: .bold) : .systemFont(ofSize: 14)
        titleLbl.textColor = isBold ? .black : .gray
        
        valueLabel.text = defaultValue
        valueLabel.font = isBold ? .systemFont(ofSize: 16, weight: .bold) : .systemFont(ofSize: 14, weight: .medium)
        valueLabel.textAlignment = .right
        
        [titleLbl, valueLabel].forEach { addSubview($0) }
        
        titleLbl.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        valueLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.greaterThanOrEqualTo(titleLbl.snp.trailing).offset(8)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setValue(_ text: String) {
        valueLabel.text = text
    }
}
