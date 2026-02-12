import UIKit
import SnapKit

class RegisterApproveController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm your email"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        
        let fullText = "We sent a code to arfi.ganteng@gmail.com."
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let emailRange = fullText.range(of: "arfi.ganteng@gmail.com") {
            let nsRange = NSRange(emailRange, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: nsRange)
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .medium), range: nsRange)
        }
        
        label.attributedText = attributedString
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.text = "Verification code"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let codeContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let codeTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let helperLabel: UILabel = {
        let label = UILabel()
        label.text = "Didn't get the email? Check your junk/spam or resend it."
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = MainButton(text: "Continue")
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        
        codeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupUI() {
        view.backgroundColor = .accent
        navigationItem.hidesBackButton = true
        
        codeContainerView.addSubview(codeTextField)
            
        [
            backButton,
            titleLabel,
            descriptionLabel,
            codeLabel,
            codeContainerView,
            helperLabel,
            continueButton
        ].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        codeContainerView.snp.makeConstraints { make in
            make.top.equalTo(codeLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        helperLabel.snp.makeConstraints { make in
            make.top.equalTo(codeContainerView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
            make.height.equalTo(56)
        }
    }
    
    @objc private func textFieldDidChange() {
        let hasText = !(codeTextField.text?.isEmpty ?? true)
        continueButton.isEnabled = hasText
        continueButton.alpha = hasText ? 1.0 : 0.5
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func continueTapped() {
        let successVC = SuccessViewController.accountCreated { [weak self] in
            self?.navigateToLogin()
        }
        navigationController?.pushViewController(successVC, animated: true)
    }
    
    private func navigateToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
}
