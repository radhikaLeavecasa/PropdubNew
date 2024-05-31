//
//  AlertPopUpVC.swift
//  PropDub
//
//  Created by acme on 31/05/24.
//

import UIKit

class AlertPopUpVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    //MARK: - Variables
    var titleStr = String()
    var descrp = String()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = titleStr
        lblDescription.text = descrp
    }
    @IBAction func actionCross(_ sender: Any) {
        dismiss(animated: true)
    }
}
