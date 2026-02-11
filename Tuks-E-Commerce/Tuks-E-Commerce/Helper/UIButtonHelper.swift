import UIKit

class MainButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        setupButton(text: text)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupButton(text: String) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = UIColor(red: 0.2, green: 0.3, blue: 0.8, alpha: 1)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.layer.cornerRadius = 12
    }
}
