import UIKit
import SnapKit

final class MainTabBarController: UITabBarController {

    private let customTabBar = CustomTabBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupCustomTabBar()
        tabBar.isHidden = true
        selectTab(index: 0)
    }

    private func setupTabs() {
        let networkService = DefaultNetworkService()
        let viewModel = HomeViewModel(networkService: networkService)
        let wishlistViewModel = WishListViewModel(networkService: networkService)
        
        let homeNav = UINavigationController(
            rootViewController: HomeViewController(
                viewModel: viewModel,
                wishlistViewModel: wishlistViewModel
            )
        )
        let storeNav = UINavigationController(
            rootViewController: StoreViewController(/*viewModel: StoreViewModel()*/)
        )
        let wishlistNav = UINavigationController(
            rootViewController: WishListViewController(/*viewModel: WishlistViewModel()*/)
        )
        let profileNav = UINavigationController(
            rootViewController: ProfileViewController(/*viewModel: ProfileViewModel()*/)
        )

        viewControllers = [homeNav, storeNav, wishlistNav, profileNav]
    }

    private func setupCustomTabBar() {
        view.addSubview(customTabBar)

        customTabBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(86)
        }

        customTabBar.onSelect = { [weak self] index in
            self?.selectTab(index: index)
        }
    }

    func selectTab(index: Int) {
        selectedIndex = index
        customTabBar.setSelected(index: index)
    }

    func hideCustomTabBar() {
        UIView.animate(withDuration: 0.3) {
            self.customTabBar.transform = CGAffineTransform(translationX: 0, y: 86)
        }
    }

    func showCustomTabBar() {
        UIView.animate(withDuration: 0.3) {
            self.customTabBar.transform = .identity
        }
    }
}
