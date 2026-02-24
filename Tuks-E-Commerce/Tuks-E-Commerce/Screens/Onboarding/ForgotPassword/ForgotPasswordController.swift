import UIKit
import SnapKit

class ForgotPasswordController: UIViewController {
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot password"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link."
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let emailTextField: UITextField = {
        CustomTextField(
            placeholder: "Enter your email",
            keyboardType: .emailAddress
        )
    }()
    
    private let submitButton: UIButton = {
        let button = MainButton(text: "Submit")
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    let viewModel: ForgotPasswordViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        bindViewModel()
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .accent
        navigationItem.hidesBackButton = true
    
        [
            closeButton,
            titleLabel,
            descriptionLabel,
            emailLabel,
            emailTextField,
            submitButton
        ].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
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
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
            make.height.equalTo(56)
        }
    }
    
    @objc private func textFieldDidChange() {
        let hasText = !(emailTextField.text?.isEmpty ?? true)
        submitButton.isEnabled = hasText
        submitButton.alpha = hasText ? 1.0 : 0.5
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func closeTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func submitTapped() {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            
            self.present(
                AlertHelper.showAlert(title: "Warning!", message: "Email input must be non-empty!"),
                animated: true
            )
            
            return
        }
                
        let body = ForgotPasswordRequest(email: email)
        viewModel.forgotPassword(body: body)
    }
    
    private func bindViewModel() {
        viewModel.forgotPasswordSuccess = {[weak self]  email in
            guard let self else { return }
            
            let changePasswordVC = ChangePasswordBuilder.build(email: email)
            navigationController?.pushViewController(changePasswordVC, animated: true)
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            guard let self else { return }
            self.present(
                AlertHelper.showAlert(title: "Warning!", message: errorText),
                animated: true
            )
        }
    }
}
