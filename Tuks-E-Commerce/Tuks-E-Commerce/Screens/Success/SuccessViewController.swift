import UIKit
import SnapKit

final class SuccessViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let checkmarkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.15)
        view.layer.cornerRadius = 80
        return view
    }()
    
    private let innerCheckmarkView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 60
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let continueButton: MainButton
    
    // MARK: - Properties
    
    private let onContinue: (() -> Void)?
    
    // MARK: - Init
    
    init(title: String, description: String, buttonText: String = "Continue", onContinue: (() -> Void)? = nil) {
        self.continueButton = MainButton(text: buttonText)
        self.onContinue = onContinue
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showTabBar()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.backgroundColor = .accent
        navigationItem.hidesBackButton = true
        
        innerCheckmarkView.addSubview(checkmarkImageView)
        checkmarkView.addSubview(innerCheckmarkView)
        
        [
            checkmarkView,
            titleLabel,
            descriptionLabel,
            continueButton
        ].forEach { view.addSubview($0) }
    }
    
    private func setupConstraints() {
        checkmarkView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.size.equalTo(160)
        }
        
        innerCheckmarkView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(120)
        }
        
        checkmarkImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(checkmarkView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(56)
        }
    }
    
    // MARK: - Actions
    
    @objc private func continueTapped() {
        onContinue?()
    }
}

// MARK: - Factory Methods

extension SuccessViewController {
    static func accountCreated(onContinue: (() -> Void)? = nil) -> SuccessViewController {
        SuccessViewController(
            title: "Your account successfully\ncreated!",
            description: "Enjoy your time shopping on the internet! Let's start!",
            onContinue: onContinue
        )
    }
    
    static func orderPlaced(onContinue: (() -> Void)? = nil) -> SuccessViewController {
        SuccessViewController(
            title: "Order placed\nsuccessfully!",
            description: "Your order is on its way. Thank you for shopping with us!",
            buttonText: "Continue Shopping",
            onContinue: onContinue
        )
    }
}
