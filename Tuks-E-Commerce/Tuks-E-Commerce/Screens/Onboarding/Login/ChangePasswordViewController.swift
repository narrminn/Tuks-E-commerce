import UIKit
import SnapKit

class ChangePasswordController: UIViewController {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Change your password"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Time to reset your password, remember don't forget to write it to notes!"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.text = "Verification Code"
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
        textField.placeholder = "enter verification code"
        textField.font = .systemFont(ofSize: 16)
        textField.keyboardType = .numberPad
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "New Password"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let passwordContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter your new password"
        textField.font = .systemFont(ofSize: 16)
        textField.isSecureTextEntry = true
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let togglePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    private let submitButton: UIButton = {
        let button = MainButton(text: "Submit")
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    private var isPasswordVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        
        codeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupUI() {
        view.backgroundColor = .accent
        navigationItem.hidesBackButton = true
        
        codeContainerView.addSubview(codeTextField)
        passwordContainerView.addSubview(passwordTextField)
        passwordContainerView.addSubview(togglePasswordButton)
            
        [
            backButton,
            closeButton,
            titleLabel,
            descriptionLabel,
            codeLabel,
            codeContainerView,
            passwordLabel,
            passwordContainerView,
            submitButton
        ].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
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
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(codeContainerView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(togglePasswordButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
        
        togglePasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
            make.height.equalTo(56)
        }
    }
    
    @objc private func textFieldDidChange() {
        let hasCode = !(codeTextField.text?.isEmpty ?? true)
        let hasPassword = !(passwordTextField.text?.isEmpty ?? true)
        let isValid = hasCode && hasPassword
        submitButton.isEnabled = isValid
        submitButton.alpha = isValid ? 1.0 : 0.5
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        togglePasswordButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func closeTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        let imageName = isPasswordVisible ? "eye" : "eye.slash"
        togglePasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func submitTapped() {
        guard let code = codeTextField.text, !code.isEmpty else {
            // Kod boşdursa xəbərdarlıq göstər
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            // Şifrə boşdursa xəbərdarlıq göstər
            return
        }
        
        // Burada kod və şifrə yoxlanışı edilə bilər
        navigateToLogin()
    }
    
    private func navigateToLogin() {
        navigationController?.popToRootViewController(animated: true)
    }
}
