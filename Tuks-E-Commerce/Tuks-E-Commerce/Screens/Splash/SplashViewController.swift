import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash-logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        goNext()
    }
    
    private func setupUI() {
        view.backgroundColor = .accent
        
        view.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(140)
        }
    }
    
    private func goNext() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if KeychainManager.shared.retrieve(key: "token") != nil {
                self.navigateToMainApp()
            } else {
                self.navigateToLogin()
            }
        }
    }
    
    private func navigateToLogin() {
        let networkService = DefaultNetworkService()
        let viewModel = LoginViewModel(networkService: networkService)
        let loginVC = LoginController(viewModel: viewModel)
        navigationController?.setViewControllers([loginVC], animated: true)
    }

    private func navigateToMainApp() {
        let tabBar = MainTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        self.present(tabBar, animated: true)
    }
}

