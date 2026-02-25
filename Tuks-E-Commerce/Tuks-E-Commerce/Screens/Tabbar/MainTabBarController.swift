import UIKit
import SnapKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .clear
    }

    private func setupTabs() {
        let networkService = DefaultNetworkService()
        let homeViewModel = HomeViewModel(networkService: networkService)
        let wishlistViewModel = WishListViewModel(networkService: networkService)
        let storeViewModel = StoreViewModel(networkService: networkService)
        
        let homeVC = HomeViewController(viewModel: homeViewModel, wishlistViewModel: wishlistViewModel)
        homeVC.tabBarItem = UITabBarItem(title: "Home",
                                         image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal),
                                         selectedImage: UIImage(named: "selected_home")?.withRenderingMode(.alwaysOriginal))

        let storeVC = StoreViewController(
            viewModel: storeViewModel,
            wishlistViewModel: wishlistViewModel
        )
        storeVC.tabBarItem = UITabBarItem(title: "Store",
                                          image: UIImage(named: "store")?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: UIImage(named: "selected_store")?.withRenderingMode(.alwaysOriginal))

        let wishlistVC = WishListViewController(viewModel: wishlistViewModel)
        wishlistVC.tabBarItem = UITabBarItem(title: "Wishlist",
                                              image: UIImage(named: "wishlist")?.withRenderingMode(.alwaysOriginal),
                                              selectedImage: UIImage(named: "selected_wishlist")?.withRenderingMode(.alwaysOriginal))

        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                             image: UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal),
                                             selectedImage: UIImage(named: "selected_profile")?.withRenderingMode(.alwaysOriginal))

        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: storeVC),
            UINavigationController(rootViewController: wishlistVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }
}
