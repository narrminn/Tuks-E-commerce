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
        self.backgroundColor = UIColor(red: 154/255, green: 150/255, blue: 138/255, alpha: 1.0)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.layer.cornerRadius = 12
    }
}
