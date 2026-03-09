import UIKit
import SnapKit

final class RegisterController: UIViewController {
    
    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account so you can explore all the\nproducts"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let nameAndSurnameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let nameTextField = CustomTextField(placeholder: "Name", keyboardType: .default)
    private let surnameTextField = CustomTextField(placeholder: "Surname", keyboardType: .default)
    private let phoneNumberTextField = CustomTextField(placeholder: "Phone number", keyboardType: .default)
    private let emailTextField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress)
    private let passwordTextField = CustomTextField(placeholder: "Password", keyboardType: .default, isSecure: true)
    
    private let signUpButton = MainButton(text: "Sign up")
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Already have an account?", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return btn
    }()
    
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.text = "Or continue with"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let socialStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let googleContainer = SocialContainerView()
    private let facebookContainer = SocialContainerView()
    private let appleContainer = SocialContainerView()
    
    private let googleImageView = SocialIconView(named: "google_icon")
    private let facebookImageView = SocialIconView(named: "facebook_icon")
    private let appleImageView = SocialIconView(named: "apple_icon")
    
    // MARK: - Properties
    
    private let viewModel: RegisterViewModel
    
    // MARK: - Init

    init(viewModel: RegisterViewModel) {
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
    
    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .accent
        navigationItem.hidesBackButton = true
        
        let containers = [googleContainer, facebookContainer, appleContainer]
        let icons = [googleImageView, facebookImageView, appleImageView]
        zip(containers, icons).forEach { $0.addSubview($1) }
        
        containers.forEach { socialStackView.addArrangedSubview($0) }
        [nameTextField, surnameTextField].forEach { nameAndSurnameStackView.addArrangedSubview($0) }
        [phoneNumberTextField, emailTextField, passwordTextField].forEach { fieldsStackView.addArrangedSubview($0) }
        [titleLabel, subtitleLabel, nameAndSurnameStackView, fieldsStackView, signUpButton, loginButton, continueLabel, socialStackView].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        nameAndSurnameStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        fieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(nameAndSurnameStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        [nameTextField, surnameTextField, phoneNumberTextField, emailTextField, passwordTextField].forEach {
            $0.snp.makeConstraints { make in make.height.equalTo(55) }
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(fieldsStackView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(emailTextField)
            make.height.equalTo(55)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        continueLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        socialStackView.snp.makeConstraints { make in
            make.top.equalTo(continueLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(50)
        }
        
        [googleImageView, facebookImageView, appleImageView].forEach { icon in
            icon.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(50)
            }
        }
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    // MARK: - Bind
    
    private func bindViewModel() {
        viewModel.userCreated = { [weak self] userId in
            let confirmEmailVC = RegisterApproveBuilder.build(userId: userId)
            self?.navigationController?.pushViewController(confirmEmailVC, animated: true)
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            self?.showError(message: errorText)
        }
    }
    
    // MARK: - Actions
    
    @objc private func loginTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUpTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let phone = phoneNumberTextField.text, !phone.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showError(message: "All input fields must be non-empty")
            return
        }
        
        viewModel.registerSubmit(
            body: RegisterRequest(email: email, name: name, surname: surname, phone: phone, password: password)
        )
    }
    
    private func showError(message: String) {
        present(AlertHelper.showAlert(title: "Warning!", message: message), animated: true)
    }
}
