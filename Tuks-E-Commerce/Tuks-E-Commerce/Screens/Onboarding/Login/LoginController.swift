import UIKit
import SnapKit

final class LoginController: UIViewController {
    
    // MARK: - UI Elements

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "tuks_logo")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = CustomTextField(placeholder: "Password", keyboardType: .default, isSecure: true)
    
    private let forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forgot your password?", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return btn
    }()
    
    private let signInButton = MainButton(text: "Sign in")
    
    private let createAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create new account", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return btn
    }()
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel
    
    // MARK: - Init

    init(viewModel: LoginViewModel) {
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
        addObservers()
    }
    
    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        [
            emailTextField,
            passwordTextField
        ].forEach { fieldsStackView.addArrangedSubview($0) }
        
        [
            logoImageView,
            fieldsStackView,
            forgotPasswordButton,
            signInButton,
            createAccountButton
        ].forEach { view.addSubview($0) }
    }
        
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(100)
        }
        
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.equalTo(passwordTextField)
        }
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(25)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(55)
        }
        
        createAccountButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupActions() {
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showPasswordChangedAlert),
            name: .passwordChanged,
            object: nil
        )
    }
    
    // MARK: - Bind
    
    private func bindViewModel() {
        viewModel.loginSuccess = { [weak self] loginResponseData in
            guard let self, let token = loginResponseData.token else { return }
            saveUserData(data: loginResponseData)
            _ = KeychainManager.shared.save(key: "token", value: token)
            navigateToMainApp()
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            self?.showError(message: errorText)
        }
    }
    
    // MARK: - Actions
    
    @objc private func forgotPasswordTapped() {
        let forgotPasswordVC = ForgotPasswordBuilder.build()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @objc private func createAccountTapped() {
        let registerVC = RegisterBuilder.build()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func signInTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showError(message: "All input fields must be non-empty")
            return
        }
        viewModel.login(body: LoginRequest(email: email, password: password))
    }
    
    @objc private func showPasswordChangedAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.present(
                AlertHelper.showAlert(title: "Success", message: "Your password has been changed successfully!"),
                animated: true
            )
        }
    }
    
    // MARK: - Helpers
    
    private func navigateToMainApp() {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    private func saveUserData(data: LoginResponseData) {
        let defaults = UserDefaults.standard
        defaults.set(data.user?.id, forKey: UserDefaultsKeys.userId)
        defaults.set(data.user?.name, forKey: UserDefaultsKeys.name)
        defaults.set(data.user?.surname, forKey: UserDefaultsKeys.surname)
        defaults.set(data.user?.email, forKey: UserDefaultsKeys.email)
        defaults.set(data.user?.phone, forKey: UserDefaultsKeys.phone)
        defaults.set(data.user?.birth, forKey: UserDefaultsKeys.birth)
        defaults.set(data.user?.profilePhotoPath, forKey: UserDefaultsKeys.profilePhotoPath)
        defaults.set(data.user?.profilePhotoUUID, forKey: UserDefaultsKeys.profilePhotoUuid)
    }
    
    private func showError(message: String) {
        present(AlertHelper.showAlert(title: "Warning!", message: message), animated: true)
    }
}
