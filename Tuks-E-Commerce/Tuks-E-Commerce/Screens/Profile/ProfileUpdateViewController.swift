import UIKit
import SnapKit

final class ProfileUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
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
    
    let viewModel: ProfileViewModel
    let fileViewModel: FileUploadViewModel
    
    init(viewModel: ProfileViewModel, fileViewModel: FileUploadViewModel) {
        self.viewModel = viewModel
        self.fileViewModel = fileViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        addSubviews()
        setupConstraints()
        bindActions()
        bindViewModel()
        
        fillUserData()
        
        if let profileImage = UserDefaults.standard.string(
            forKey: UserDefaultsKeys.profilePhotoPath
        ) {
            profileImageView.loadImage(url: profileImage)
        }
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
    
    @objc private func profileImageTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImageView.image = image
        
        uploadProfilePhoto(image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func uploadProfilePhoto(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        fileViewModel.photoUpload(data: imageData)
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
    
    private func fillUserData() {
        nameTextField.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.name)
        surnameTextField.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.surname)
        phoneTextField.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.phone)
        birthTextField.text = UserDefaults.standard.string(forKey: UserDefaultsKeys.birth)
        
        if let photoPath = UserDefaults.standard.string(forKey: UserDefaultsKeys.profilePhotoPath) {
            profileImageView.loadImage(url: photoPath)
        }
    }
    
    private func bindActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    @objc private func saveTapped() {
        if let name = nameTextField.text, !name.isEmpty,
           let surname = surnameTextField.text, !surname.isEmpty,
           let phone = phoneTextField.text, !phone.isEmpty {
            
            viewModel
                .updateProfile(
                    name: name,
                    surname: surname,
                    phone: phone,
                    birth: birthTextField.text
                )
        }
    }
    
    private func bindViewModel() {
        fileViewModel.photoUploadSuccess = { [weak self] fileUploadResponse in
            guard let self else { return }
            
            self.viewModel.fileUploadResponse = fileUploadResponse
        }
        
        fileViewModel.errorHandling = { [weak self] errorText in
            guard let self else { return }
            
            self.present(
                AlertHelper.showAlert(
                    title: "Warning!",
                    message: errorText
                ),
                animated: true
            )
        }
        
        viewModel.photoUpdateSuccess = { [weak self] in
            guard let self else { return }
            
            UserDefaults.standard
                .set(nameTextField.text, forKey: UserDefaultsKeys.name)
            UserDefaults.standard
                .set(surnameTextField.text, forKey: UserDefaultsKeys.surname)
            UserDefaults.standard
                .set(phoneTextField.text, forKey: UserDefaultsKeys.phone)
            UserDefaults.standard
                .set(birthTextField.text, forKey: UserDefaultsKeys.birth)
            
            if let profilePhoto = self.viewModel.fileUploadResponse {
                UserDefaults.standard
                    .set(
                        profilePhoto.data?.file?.path,
                        forKey: UserDefaultsKeys.profilePhotoPath
                    )
                UserDefaults.standard
                    .set(
                        profilePhoto.data?.file?.id,
                        forKey: UserDefaultsKeys.profilePhotoUuid
                    )
            }
        }
        
        viewModel.errorHandling = { [weak self] errorText in
            guard let self else { return }
            
            self.present(
                AlertHelper.showAlert(
                    title: "Warning!",
                    message: errorText
                ),
                animated: true
            )
        }
    }
}
