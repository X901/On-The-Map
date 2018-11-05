

import Foundation
import UIKit

struct Alert {
    
  static func showBasicAlert(on vc: UIViewController, with message: String) {
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
 
    

}
