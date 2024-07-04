//
//  AddPropertyTwoVC.swift
//  PropDub
//
//  Created by acme on 03/07/24.
//

import UIKit
import IQKeyboardManagerSwift

class AddPropertyTwoVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var txtVwDescription: IQTextView!
    @IBOutlet weak var txtVwLocation: IQTextView!
    @IBOutlet weak var txtVwAmenities: IQTextView!
    @IBOutlet weak var txtFldBrochure: UITextField!
    @IBOutlet weak var txtFldLogo: UITextField!
    @IBOutlet weak var txtFldHandover: UITextField!
    @IBOutlet weak var txtFldImage: UITextField!
    @IBOutlet weak var txtFldGallery: UITextField!
    @IBOutlet var actionOptions: [UIButton]!
    @IBOutlet weak var txtFldMapVideo: UITextField!
    @IBOutlet weak var addVideo: UITextField!
    @IBOutlet weak var txtFldUnitPrice: UITextField!
    @IBOutlet weak var txtFldAddMasterPlan: UITextField!
    @IBOutlet weak var txtFldAddFloor: UITextField!
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK: - @IBActions
    @IBAction func actionProfile(_ sender: Any) {
    }
    
    @IBAction func actionNotifications(_ sender: Any) {
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
    }
    @IBAction func actionListingAddProject(_ sender: Any) {
    }
    @IBAction func actionUploadImage(_ sender: Any) {
        txtFldImage.becomeFirstResponder()
    }
    @IBAction func actionGallery(_ sender: Any) {
        txtFldGallery.becomeFirstResponder()
    }
    @IBAction func actionLogo(_ sender: Any) {
        txtFldLogo.becomeFirstResponder()
    }
}
