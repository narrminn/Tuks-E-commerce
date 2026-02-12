import UIKit
import SnapKit

class RegisterController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = UIColor(red: 0.2, green: 0.3, blue: 0.8, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account so you can explore all the\nproducts"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
    
    private let nameTextField: UITextField = {
        return CustomTextField(
            placeholder: "Name",
            keyboardType: .default
        )
    }()
    
    private let surnameTextField: UITextField = {
        return CustomTextField(
            placeholder: "Surname",
            keyboardType: .default
        )
    }()
    
    private let phoneNumberTextField: UITextField = {
        return CustomTextField(
            placeholder: "Phone number",
            keyboardType: .default
        )
    }()
    
    private let emailTextField: UITextField = {
        return CustomTextField(
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
    
    private let signUpButton: UIButton = {
        return MainButton(text: "Sign up")
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Already have an account?", for: .normal)
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
        view.backgroundColor = .accent
        navigationItem.hidesBackButton = true
        
        googleContainer.addSubview(googleImageView)
        facebookContainer.addSubview(facebookImageView)
        appleContainer.addSubview(appleImageView)
        
        socialStackView.addArrangedSubview(googleContainer)
        socialStackView.addArrangedSubview(facebookContainer)
        socialStackView.addArrangedSubview(appleContainer)
        
        nameAndSurnameStackView.addArrangedSubview(nameTextField)
        nameAndSurnameStackView.addArrangedSubview(surnameTextField)
        
        fieldsStackView.addArrangedSubview(phoneNumberTextField)
        fieldsStackView.addArrangedSubview(emailTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        
        [
            titleLabel,
            subtitleLabel,
            nameAndSurnameStackView,
            fieldsStackView,
            signUpButton,
            loginButton,
            continueLabel,
            socialStackView
        ].forEach(view.addSubview)
        
        setupConstraints()
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
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(55)
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
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUpTapped() {
        let confirmEmailVC = RegisterApproveController()
            navigationController?.pushViewController(confirmEmailVC, animated: true)
    }
}
