import UIKit
import SnapKit

final class ProfileUpdateViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile_mock")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let cameraIconView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "camera.fill")
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let cameraOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    private let nameTextField: UITextField = {
        CustomTextField(placeholder: "Name", keyboardType: .default)
    }()
    
    private let surnameTextField: UITextField = {
        CustomTextField(placeholder: "Surname", keyboardType: .default)
    }()
    
    private let phoneTextField: UITextField = {
        CustomTextField(placeholder: "Phone", keyboardType: .phonePad)
    }()
    
    private let birthTextField: UITextField = {
        CustomTextField(placeholder: "Birth Date", keyboardType: .default)
    }()
    
    private let saveButton: UIButton = {
        MainButton(text: "Save")
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        addSubviews()
        setupConstraints()
        bindActions()
        
        // TODO: viewModel bağla, mövcud məlumatları textfield-lara doldur
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        hideTabBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        showTabBar()
    }
    
    // MARK: - Setup
    
    private func addSubviews() {
        view.backgroundColor = .systemGray6
        title = "Edit Profile"
        
        view.addSubview(profileImageView)
        profileImageView.addSubview(cameraOverlay)
        cameraOverlay.addSubview(cameraIconView)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(birthTextField)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        cameraOverlay.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cameraIconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(28)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        birthTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(birthTextField.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
    }
    
    // MARK: - Actions
    
    private func bindActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    @objc private func profileImageTapped() {
        // TODO: Kitabxana əlavə edəndə buraya image picker kodunu yaz
    }
    
    @objc private func saveTapped() {
        // TODO: viewModel.updateProfile(...) çağır
    }
}
