import UIKit

class CustomTextField: UITextField {
    init(
        placeholder: String,
        keyboardType: UIKeyboardType,
        isSecure: Bool = false
    ) {
        super.init(frame: .zero)
        
        setupTextfield(placeholder: placeholder,
                       keyboardType: keyboardType,
                       isSecure: isSecure)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupTextfield(
        placeholder: String,
        keyboardType: UIKeyboardType,
        isSecure: Bool
    ) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecure 
        self.font = .systemFont(ofSize: 16)
        self.autocapitalizationType = .none
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        self.backgroundColor = .white
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        self.leftViewMode = .always
    }
    
}
