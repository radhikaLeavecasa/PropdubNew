//
//  AlertThankyouVC.swift
//  PropDub
//
//  Created by acme on 06/06/24.
//

import UIKit

class AlertThankyouVC: UIViewController {
    //MARK: - Variables
    typealias filterCompletion = (_ isCompletion: Bool) -> Void
    var filterComplDelegate: filterCompletion? = nil
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - @IBActions
    @IBAction func actionDone(_ sender: Any) {
        self.dismiss(animated: true) {
            guard let filter = self.filterComplDelegate else { return }
            filter(true)
        }
    }
}
