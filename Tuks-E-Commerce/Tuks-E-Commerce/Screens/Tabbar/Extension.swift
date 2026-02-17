import UIKit

extension UIViewController {

    func hideTabBar() {
        (tabBarController as? MainTabBarController)?.hideCustomTabBar()
    }

    func showTabBar() {
        (tabBarController as? MainTabBarController)?.showCustomTabBar()
    }
}
