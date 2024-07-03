//
//  AddPropertyVC.swift
//  PropDub
//
//  Created by acme on 03/07/24.
//

import UIKit

class AddPropertyVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtFldArea: UITextField!
    @IBOutlet weak var txtFldUnit: UITextField!
    @IBOutlet weak var txtFldPrice: UITextField!
    @IBOutlet weak var txtFldLocation: UITextField!
    @IBOutlet weak var txtFldTowerName: UITextField!
    @IBOutlet weak var txtFldDeveloper: UITextField!
    @IBOutlet weak var txtFldAgent: UITextField!
    @IBOutlet weak var txtFldType: UITextField!
    @IBOutlet weak var txtFldSubCategory: UITextField!
    @IBOutlet weak var txtFldCategory: UITextField!
    @IBOutlet var btnOptions: [UIButton]!
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - @IBActions
    @IBAction func actionProfile(_ sender: Any) {
    }
    
    @IBAction func actionNotifications(_ sender: Any) {
    }
    
    @IBAction func actionNext(_ sender: Any) {
    }
    @IBAction func actionListingAddProject(_ sender: Any) {
    }
    
}
