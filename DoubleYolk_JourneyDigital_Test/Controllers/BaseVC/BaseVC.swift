//
//  BaseVC.swift
/
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = false
    }

}

extension UIViewController {
    func showAlert(withTitle title: String, andMessage message:String) {
        let alert = UIAlertController(title: title, message: message,
                                  preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style:
        UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
