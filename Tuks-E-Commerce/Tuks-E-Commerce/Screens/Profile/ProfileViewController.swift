import UIKit
import SnapKit
import SafariServices

final class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profile_mock")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 30
        iv.clipsToBounds = true
        return iv
    }()
    
    private let userInfoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Narmin Alasova"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "narmin@mail.com"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "profile_edit"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let aboutTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "About Tuks"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .clear
        tv.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        tv.isScrollEnabled = false
        tv.dataSource = self
        tv.delegate = self
        tv.register(AboutTuksCell.self, forCellReuseIdentifier: AboutTuksCell.identifier)
        return tv
    }()
    
    private let logoutButton: UIButton = {
        return MainButton(text: "Logout")
    }()
    
    // MARK: - Data
    
    private let menuItems: [(icon: String, title: String, url: String)] = [
        ("note",    "Terms & Conditions",          "https://tuks.az/terms"),
        ("privacy_policy",  "Privacy Policy",              "https://tuks.az/privacy"),
        ("property_rights", "Intellectual Property Rights","https://tuks.az/intellectual-property")
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addSubviews()
        setupConstraints()
        bindActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup
    
    private func addSubviews() {
        userInfoStack.addArrangedSubview(nameLabel)
        userInfoStack.addArrangedSubview(emailLabel)
        
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(userInfoStack)
        view.addSubview(editButton)
        view.addSubview(aboutTitleLabel)
        view.addSubview(tableView)
        view.addSubview(logoutButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(60)
        }
        
        editButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(profileImageView)
            make.size.equalTo(24)
        }
        
        userInfoStack.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.centerY.equalTo(profileImageView)
            make.trailing.equalTo(editButton.snp.leading).offset(-8)
        }
        
        aboutTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(aboutTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(menuItems.count * 56 + 60)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
    }
    
    // MARK: - Actions
    
    private func bindActions() {
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func editTapped() {
        let vc = ProfileUpdateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func logoutTapped() {
        // TODO: Logout
    }
    
    private func openBrowser(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AboutTuksCell.identifier,
            for: indexPath
        ) as? AboutTuksCell else { return UITableViewCell() }
        
        let item = menuItems[indexPath.row]
        cell.configure(icon: item.icon, title: item.title)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openBrowser(urlString: menuItems[indexPath.row].url)
    }
}
