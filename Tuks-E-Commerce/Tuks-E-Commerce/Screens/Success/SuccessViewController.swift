import UIKit
import SnapKit

class SuccessViewController: UIViewController {
    
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
    
    private let continueButton: UIButton = {
        return MainButton(text: "Continue")
    }()
    
    private let titleText: String
    private let descriptionText: String
    private let buttonText: String
    private let onContinue: (() -> Void)?
    
    init(title: String, description: String, buttonText: String = "Continue", onContinue: (() -> Void)? = nil) {
        self.titleText = title
        self.descriptionText = description
        self.buttonText = buttonText
        self.onContinue = onContinue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        configure()
    }
    
    private func setupUI() {
        view.backgroundColor = .accent
        navigationItem.hidesBackButton = true
        
        checkmarkView.addSubview(innerCheckmarkView)
        innerCheckmarkView.addSubview(checkmarkImageView)
            
        [
            checkmarkView,
            titleLabel,
            descriptionLabel,
            continueButton
        ].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        checkmarkView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.width.height.equalTo(160)
        }
        
        innerCheckmarkView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        checkmarkImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(checkmarkView.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(56)
        }
    }
    
    private func setupActions() {
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }
    
    private func configure() {
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        
        if continueButton is MainButton {
            continueButton.setTitle(buttonText, for: .normal)
        }
    }
    
    @objc private func continueTapped() {
        onContinue?()
    }
}

extension SuccessViewController {
    static func accountCreated(onContinue: (() -> Void)? = nil) -> SuccessViewController {
        return SuccessViewController(
            title: "Your account successfully\ncreated!",
            description: "Enjoy your time shopping on the internet! Let's start!",
            buttonText: "Continue",
            onContinue: onContinue
        )
    }
}
