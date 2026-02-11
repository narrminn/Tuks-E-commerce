import UIKit
import SnapKit

class LoginController: UIViewController {
    
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
    
    private let emailTextField: UITextField = {
        CustomTextField(
            placeholder: "Email",
            keyboardType: .emailAddress
        )
    }()
    
    private let passwordTextField: UITextField = {
        return CustomTextField(
            placeholder: "Password",
            keyboardType: .default,
            isSecure: true
        )
    }()
    
    private let forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forgot your password?", for: .normal)
        btn.setTitleColor(UIColor(red: 0.2, green: 0.3, blue: 0.8, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return btn
    }()
    
    private let signInButton: UIButton = {
        return MainButton(text: "Sign in")
    }()
    
    private let createAccountButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Create new account", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return btn
    }()
    
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.text = "Or continue with"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(red: 0.2, green: 0.3, blue: 0.8, alpha: 1)
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
    
    private let googleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let facebookContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let appleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let googleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "google_icon")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let facebookImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "facebook_icon")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let appleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "apple_icon")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        googleContainer.addSubview(googleImageView)
        facebookContainer.addSubview(facebookImageView)
        appleContainer.addSubview(appleImageView)
        
        socialStackView.addArrangedSubview(googleContainer)
        socialStackView.addArrangedSubview(facebookContainer)
        socialStackView.addArrangedSubview(appleContainer)
        
        fieldsStackView.addArrangedSubview(emailTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        
        [
            logoImageView,
            fieldsStackView,
            forgotPasswordButton,
            signInButton,
            createAccountButton,
            continueLabel,
            socialStackView
        ].forEach(view.addSubview)
            
            setupConstraints()
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
        
        continueLabel.snp.makeConstraints { make in
            make.top.equalTo(createAccountButton.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        socialStackView.snp.makeConstraints { make in
            make.top.equalTo(continueLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(50)
        }
        
        googleImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        facebookImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        appleImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self,action: #selector(forgotPasswordTapped),for: .touchUpInside)
    }
    
    @objc private func forgotPasswordTapped() {
        let forgotPasswordVC = ForgotPasswordController()
            navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
    
    @objc private func createAccountTapped() {
        let registerVC = RegisterController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func signInTapped() {
        //TO DO
    }
}
