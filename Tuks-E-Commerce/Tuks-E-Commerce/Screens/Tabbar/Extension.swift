import UIKit

extension UIViewController {
    func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }

    func showTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
}
