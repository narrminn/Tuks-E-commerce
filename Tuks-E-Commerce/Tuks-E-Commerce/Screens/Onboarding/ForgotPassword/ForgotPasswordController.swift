import UIKit
import SnapKit

final class ForgotPasswordController: UIViewController {
    
    // MARK: - UI Elements

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
    
    private let emailTextField = CustomTextField(placeholder: "Enter your email", keyboardType: .emailAddress)
    
    private let submitButton: MainButton = {
        let button = MainButton(text: "Submit")
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    // MARK: - Properties
    
    private let viewModel: ForgotPasswordViewModel
    
    // MARK: - Init

    init(viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        [
            closeButton,
            titleLabel,
            descriptionLabel,
            emailLabel,
            emailTextField,
            submitButton
        ].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        submitButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-20)
            make.height.equalTo(56)
        }
    }
    
    private func setupActions() {
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    // MARK: - Bind
    
    private func bindViewModel() {
        viewModel.forgotPasswordSuccess = { [weak self] email in
            let changePasswordVC = ChangePasswordBuilder.build(email: email)
            self?.navigationController?.pushViewController(changePasswordVC, animated: true)
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            self?.showError(message: errorText)
        }
    }
    
    // MARK: - Actions
    
    @objc private func closeTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func submitTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showError(message: "Email input must be non-empty!")
            return
        }
        viewModel.forgotPassword(body: ForgotPasswordRequest(email: email))
    }
    
    @objc private func textFieldDidChange() {
        let hasText = !(emailTextField.text?.isEmpty ?? true)
        submitButton.isEnabled = hasText
        submitButton.alpha = hasText ? 1.0 : 0.5
    }
    
    private func showError(message: String) {
        present(AlertHelper.showAlert(title: "Warning!", message: message), animated: true)
    }
}
