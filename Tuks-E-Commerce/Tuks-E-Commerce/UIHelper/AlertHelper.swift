import Foundation
import UIKit

class AlertHelper {
    static func showAlert(title: String, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message ?? "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        
        return alertController
    }
}
