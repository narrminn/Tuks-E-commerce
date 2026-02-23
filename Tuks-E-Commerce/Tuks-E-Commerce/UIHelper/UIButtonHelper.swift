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
        self.backgroundColor = UIColor(red: 75/255, green: 104/255, blue: 255/255, alpha: 1)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        self.layer.cornerRadius = 12
    }
}
