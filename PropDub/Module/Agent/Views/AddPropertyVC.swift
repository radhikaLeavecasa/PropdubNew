//
//  AddPropertyVC.swift
//  PropDub
//
//  Created by acme on 03/07/24.
//

import UIKit
import DropDown

class AddPropertyVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var lblListingHeading: UILabel!
    @IBOutlet weak var cnstTblVwHeight: NSLayoutConstraint!
    @IBOutlet weak var tblVwPropertyList: UITableView!
    @IBOutlet weak var vwAddPropert: UIView!
    @IBOutlet weak var vwListing: UIView!
    @IBOutlet weak var cnstCollVwHeightType: NSLayoutConstraint!
    @IBOutlet weak var collVwType: UICollectionView!
    @IBOutlet weak var cnstCollVwHeightSubCat: NSLayoutConstraint!
    @IBOutlet weak var collVwSubCategory: UICollectionView!
    @IBOutlet weak var cnstCollVwHeightCategory: NSLayoutConstraint!
    @IBOutlet weak var collVwCategory: UICollectionView!
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
    @IBOutlet var vwListingProperty: [UIView]!
    @IBOutlet var lblListingAgent: [UILabel]!
    @IBOutlet var imgVwOptions: [UIImageView]!
    //MARK: - Variables
    var viewModel = AddPropertyVM()
    let dropDown = DropDown()
    var arrCat = [String]()
    var arrSubCat = [String]()
    var arrType = [String]()
    var arrDevelopers = [String]()
    
    var arrSelectedCat = [String]()
    var arrSelectedSubCat = [String]()
    var arrSelectedType = [String]()
    var arrSelectedDevelopers = [String]()
    
    var arrMyProperty: [DataItemModel]?
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        actionListingAddProject(btnOptions[0])
        tblVwPropertyList.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        let group = DispatchGroup()
        Proxy.shared.loadAnimation()
        group.enter()
        viewModel.categoryApi { val, msg in
            if val {
                for i in self.viewModel.arrCategoryModel ?? [] {
                    self.arrCat.append(i.name)
                }
                for i in Proxy.shared.arrDeveloperList ?? [] {
                    self.arrDevelopers.append(i.name ?? "")
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                } else {
                    Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                }
            }
            group.leave()
        }
        
        group.enter()
        viewModel.subCategoryApi({ val, msg in
            if val {
                for i in self.viewModel.arrSubCategoryModel ?? [] {
                    self.arrSubCat.append(i.name)
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                } else {
                    Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                }
            }
            group.leave()
        })
        
        group.enter()
        viewModel.typeApi({ val, msg in
            if val {
                for i in self.viewModel.arrType ?? [] {
                    self.arrType.append(i.name)
                }
            } else {
                if msg == CommonError.INTERNET {
                    Proxy.shared.presentAlert(CommonMessage.NO_INTERNET_CONNECTION, titleMsg: "Oops!", vc: self)
                } else {
                    Proxy.shared.presentAlert(msg, titleMsg: "Oops!", vc: self)
                }
            }
            group.leave()
        })
       
        group.notify(queue: .main) {
            self.arrMyProperty = Proxy.shared.arrPropertyList?.filter({$0.agent?.id == Cookies.userInfo()?.id})
            self.lblListingHeading.text = self.arrMyProperty?.count == 0 ? "No Property Added Yet!" : "My Listed Properties"
            Proxy.shared.stopAnimation()
            self.tblVwPropertyList.reloadData()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    self.cnstTblVwHeight.constant = newSize.height
                }
            }
        }
    }
    
    //MARK: - @IBActions
    @IBAction func actionDeveloper(_ sender: Any) {
        txtFldDeveloper.becomeFirstResponder()
    }
    @IBAction func actionType(_ sender: Any) {
        txtFldType.becomeFirstResponder()
    }
    @IBAction func actionSubCategory(_ sender: Any) {
    }
    @IBAction func actionCategory(_ sender: Any) {
    }
    @IBAction func actionProfile(_ sender: Any) {
        let vc = ViewControllerHelper.getViewController(ofType: .ProfileVC, StoryboardName: .Main) as! ProfileVC
        vc.isLogin = false
        self.pushView(vc: vc)
        
    }
    
    @IBAction func actionNotifications(_ sender: Any) {
    }
    
    @IBAction func actionNext(_ sender: Any) {
    }
    @IBAction func actionListingAddProject(_ sender: UIButton) {
        for btn in btnOptions {
            vwListingProperty[btn.tag].backgroundColor = sender.tag == btn.tag ? .black : .clear
            if sender.tag == btn.tag {
                vwListingProperty[btn.tag].backgroundColor = .black
                lblListingAgent[btn.tag].textColor = .white
                imgVwOptions[btn.tag].image = sender.tag == 0 ? UIImage(named: "ic_listing_selected") : UIImage(named: "ic_listing_unselected")
                imgVwOptions[btn.tag].image = sender.tag == 1 ? UIImage(named: "ic_addProp_Selected") : UIImage(named: "ic_addprop_Unselected")
            } else {
                vwListingProperty[btn.tag].backgroundColor = .clear
                lblListingAgent[btn.tag].textColor = .black
                imgVwOptions[btn.tag].image = sender.tag == 0 ? UIImage(named: "ic_listing_selected") : UIImage(named: "ic_listing_unselected")
                imgVwOptions[btn.tag].image = sender.tag == 1 ? UIImage(named: "ic_addProp_Selected") : UIImage(named: "ic_addprop_Unselected")
            }
        }
        vwListing.isHidden = sender.tag == 1
        vwAddPropert.isHidden = sender.tag == 0
    }
}

extension AddPropertyVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      
        if textField == txtFldCategory {
            self.showShortDropDown(textFeild: textField, data: arrCat, dropDown: dropDown) { val, index in
                self.arrSelectedCat.append(val)
            }
            return false
        } else if textField == txtFldSubCategory {
            self.showShortDropDown(textFeild: textField, data: arrSubCat, dropDown: dropDown) { val, index in
                self.arrSelectedSubCat.append(val)
            }
            return false
        } else if textField == txtFldType {
            self.showShortDropDown(textFeild: textField, data: arrType, dropDown: dropDown) { val, index in
                self.arrSelectedType.append(val)
            }
            return false
        } else if textField == txtFldDeveloper {
            self.showShortDropDown(textFeild: textField, data: arrDevelopers, dropDown: dropDown) { val, index in
                self.txtFldDeveloper.text = val
            }
            return false
        } else {
            return true
        }
    }
}

extension AddPropertyVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == collVwCategory ? arrSelectedCat.count : collectionView == collVwSubCategory ? arrSelectedSubCat.count : arrSelectedType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactOptionsCVC", for: indexPath) as! ContactOptionsCVC
        if collectionView == collVwCategory {
            cell.lblTitle.text = arrSelectedSubCat[indexPath.row]
        } else if collectionView == collVwCategory {
            cell.lblTitle.text = arrSelectedSubCat[indexPath.row]
        } else if collectionView == collVwCategory {
            cell.lblTitle.text = arrSelectedType[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = collectionView == collVwCategory ? arrSelectedSubCat[indexPath.item] : collectionView == collVwSubCategory ? arrSelectedSubCat[indexPath.row] : arrSelectedType[indexPath.row]
        label.sizeToFit()
        if collectionView == collVwCategory {
            return CGSize(width: label.frame.width+15, height: self.collVwCategory.frame.size.height)
        } else if collectionView == collVwSubCategory {
            return CGSize(width: label.frame.width+15, height: self.collVwSubCategory.frame.size.height)
        } else {
            return CGSize(width: label.frame.width+15, height: self.collVwType.frame.size.height)
        }
    }
}

extension AddPropertyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrMyProperty?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyListingTVC") as! MyListingTVC
        cell.backgroundColor = .clear
        cell.lblName.text = arrMyProperty?[indexPath.row].location
        cell.lblLocation.text = arrMyProperty?[indexPath.row].unit
        cell.lblPrice.text = arrMyProperty?[indexPath.row].startingPrice
        cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrMyProperty?[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = ViewControllerHelper.getViewController(ofType: .PropertyDetailVC, StoryboardName: .Main) as? PropertyDetailVC {
            vc.propertyDetail = arrMyProperty?[indexPath.row]
            self.pushView(vc: vc)
        }
    }
}
