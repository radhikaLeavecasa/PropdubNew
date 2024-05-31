//
//  ViewController.swift
//  PropDub
//
//  Created by acme on 14/05/24.
//

import UIKit
import DropDown

class PropertyListVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var cnstCollVwLocation: NSLayoutConstraint!
    @IBOutlet weak var collVwLocations: UICollectionView!
    @IBOutlet weak var lblPropertyType: UILabel!
    @IBOutlet weak var txtFldSearch: UITextField!
    @IBOutlet weak var collVwPropertyList: UICollectionView!
    //MARK: - Variables
    var type = Int()
    let dropDown = DropDown()
    var arrProperty = [DataItemModel]()
    var filterArr = [DataItemModel]()
    var minValue = 0
    var maxValue = 90000000
    var arrFilteredAmenities = [String]()
    var arrFilteredConfiguration = [String]()
    var image = UIImage()
    var arrLocation = [String]()
    var arrSelectedLocation = [String]()
    var isFilter = false
    var arrFilteredName = [String]()
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collVwPropertyList.registerNib(nibName: "ExclusiveCVC")
        if type == 1 {
            lblPropertyType.text = "Residential"
            arrProperty = Proxy.shared.arrPropertyList?.filter({($0.cat?.range(of: "Residential", options: .caseInsensitive) != nil) || ($0.type?.range(of: "Residential", options: .caseInsensitive) != nil)}) ?? []
        } else if type == 2 {
            lblPropertyType.text = "Commercial"
            arrProperty = Proxy.shared.arrPropertyList?.filter({($0.cat?.range(of: "Commercial", options: .caseInsensitive) != nil) || ($0.type?.range(of: "Commercial", options: .caseInsensitive) != nil)}) ?? []
        } else if type == 3 {
            lblPropertyType.text = "Off Plan"
            arrProperty = Proxy.shared.arrPropertyList?.filter({($0.cat?.range(of: "Off Plan", options: .caseInsensitive) != nil) || ($0.type?.range(of: "Off Plan", options: .caseInsensitive) != nil)}) ?? []
        } else if type == 4 {
            lblPropertyType.text = "Secondary Market"
            arrProperty = Proxy.shared.arrPropertyList?.filter({($0.cat?.range(of: "Secondary Market", options: .caseInsensitive) != nil) || ($0.type?.range(of: "Secondary Market", options: .caseInsensitive) != nil)}) ?? []
        } else {
            lblPropertyType.text = "All Properties"
            arrProperty = Proxy.shared.arrPropertyList ?? []
        }
        
        for i in Proxy.shared.arrPropertyList ?? [] {
            if let location = i.location, !location.isEmpty {
                arrLocation.append(location)
            }
        }

        let uniqueLocations = Array(Set(arrLocation))
        arrLocation = uniqueLocations
        
        filterArr = arrProperty
        collVwPropertyList.reloadData()
    }
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
    @IBAction func actionFilter(_ sender: Any) {
        
//        var params: [String: AnyObject] = ["name": "Radhika",
//                                            "email": "radhika@leavecasa.com",
//                                            "mobile": "9041723151",
//                                            "description": "sdfsdg"] as! [String: AnyObject]
//                                          
//        var imgParam: [String: UIImage] = ["aadhar1": image,
//                                           "aadhar2": image,
//                                           "passport": image]
//        
//        
//        self.callEditProfile(param: params, dictImage: imgParam)
        if let vc = ViewControllerHelper.getViewController(ofType: .FilterVC, StoryboardName: .Main) as? FilterVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            vc.minValue = self.minValue
            vc.maxValue = self.maxValue
            vc.selectedAmenity = self.arrFilteredAmenities
            vc.selectedConf = self.arrFilteredConfiguration
            var arrName = [String]()
            for i in filterArr {
                arrName.append(i.name ?? "")
            }
            
            var uniqueItems = Set<String>()
            
            for item in arrName {
                uniqueItems.insert(item)
            }
            arrName = Array(uniqueItems)
            vc.arrName = arrName
            
            vc.filterComplDelegate = {
                minVal,maxVal,arrAmenity,arrConf,isClear, arrSelectedNames in
                
                self.minValue = minVal
                self.maxValue = maxVal
                self.arrFilteredAmenities = arrAmenity
                self.arrFilteredConfiguration = arrConf
                self.arrFilteredName = arrSelectedNames
                self.filterData(minVal: minVal, maxVal: maxVal, arrAmenity: arrAmenity, arrConf: arrConf,isClear: isClear, arrSelectedNames: arrSelectedNames)
            }
            self.present(vc, animated: true)
        }
    }
    func countDigitsAfterDecimalPoint(_ number: String) -> Int {
        if let range = number.range(of: Locale.current.decimalSeparator ?? ".") {
            let digitsAfterDecimal = number.distance(from: range.upperBound, to: number.endIndex)
            return max(0, digitsAfterDecimal)
        } else {
            return 0
        }
    }
    func filterData(minVal:Int,maxVal:Int,arrAmenity:[String],arrConf:[String],isClear:Bool, arrSelectedNames:[String]){
        if !isClear {
            isFilter = true
            //Filter Amenities
            if arrAmenity.count > 0 {
                var halfCount = 0
                if arrAmenity.count % 2 == 0 {
                    halfCount = arrAmenity.count/2
                } else {
                    halfCount = Int((Double((arrAmenity.count/2))+0.5).rounded())
                }
                
                for i in 0..<arrProperty.count {
                    
                    var matchCount = 0
                    for j in 0..<arrAmenity.count {
                        if arrProperty[i].amenities?.contains(arrAmenity[j]) == true {
                            matchCount += 1
                            if matchCount == halfCount {
                                filterArr.append(arrProperty[i])
                            }
                        }
                    }
                }
                //                    if filterArr.count == 0 {
                //                        binding.rvProperty.visibility = View.GONE
                //                        binding.tvTitle.setText("No Property Found!")
                //                        return
                //                    }
            }
            
            //Configuration Filter
            if arrConf.count > 0 {
                for i in arrConf {
                    let arr = self.arrProperty.filter({$0.unit?.contains(i) == true})
                    filterArr.append(contentsOf: arr)
                }
            }
            
            //Filter Price
            self.filterArr = self.arrProperty.filter { property in
                
                var propertyPrice = property.startingPrice?.replacingOccurrences(of: "AED", with: "")
                
                propertyPrice = propertyPrice?.replacingOccurrences(of: "on demand", with: "0")
                propertyPrice = propertyPrice?.replacingOccurrences(of: ",", with: "")
                propertyPrice = propertyPrice?.replacingOccurrences(of: "*", with: "")
                
                if propertyPrice?.contains(".") == true {
                    var numericCount = self.countDigitsAfterDecimalPoint(propertyPrice ?? "0")
                    propertyPrice = propertyPrice?.replacingOccurrences(of: ".", with: "")
                    if numericCount == 1 {
                        propertyPrice = propertyPrice?.replacingOccurrences(of: "million", with: "00000")
                    } else if numericCount == 2 {
                        propertyPrice = propertyPrice?.replacingOccurrences(of: "million", with: "0000")
                    } else if numericCount == 3 {
                        propertyPrice = propertyPrice?.replacingOccurrences(of: "million", with: "000")
                    }
                }
                propertyPrice = propertyPrice?.replacingOccurrences(of: "million", with: "0000000")
                propertyPrice = propertyPrice?.replacingOccurrences(of: "k", with: "0000")
                
                propertyPrice = propertyPrice?.trimmingCharacters(in: .whitespaces)
                
                if let startingPriceNumeric = Int(propertyPrice ?? "0") {
                    return minVal >= startingPriceNumeric && startingPriceNumeric <= maxVal
                } else {
                    return false
                }
            }
            
            for i in arrSelectedLocation {
                for j in arrProperty {
                    if j.location?.contains(i) == true {
                        filterArr.append(j)
                    }
                }
            }
            
            for i in arrSelectedNames {
                for j in arrProperty {
                    if j.name?.contains(i) == true {
                        self.filterArr.append(j)
                    }
                }
            }
            
            
            var uniqueItems = Set<DataItemModel>()
            
            for item in filterArr {
                uniqueItems.insert(item)
            }
            filterArr = Array(uniqueItems)
        } else {
            isFilter = false
            filterArr = arrProperty
        }
        collVwPropertyList.reloadData()
    }
    
    
//    func callEditProfile(param:[String:Any],dictImage: [String: UIImage]){
//        Proxy.shared.loadAnimation(show: true)
//        WebService.uploadImageWithURL(api: .saveSuperAgent, dictImage: dictImage, parameter: param) { status, msg, response in
//            
//            Proxy.shared.loadAnimation(show: false)
//            if status {
//                let responseData = response as? [String:Any] ?? [:]
//                //                if let data = responseData[CommonParam.DATA] as? [String:Any]{
//                //                    Cookies.userInfoSave(dict: data)
//                //                }
//                // self.delegate?.onSuccess()
//            }else{
//                if msg == CommonError.INTERNET{
//                    //  view.pushNoInterConnection(view: view)
//                }else{
//                    Proxy.shared.loadAnimation(show: false)
//                    //self.pushNoInterConnection(view: view,titleMsg: "Alert", msg: msg)
//                }
//            }
//        }
//    }
}

extension PropertyListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == collVwLocations ? arrSelectedLocation.count : filterArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collVwLocations {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactOptionsCVC", for: indexPath) as! ContactOptionsCVC
            cell.lblTitle.text = arrSelectedLocation[indexPath.row]
            cell.btnCheck.tag = indexPath.row
            cell.btnCheck.addTarget(self, action: #selector(actionCross), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExclusiveCVC", for: indexPath) as! ExclusiveCVC
            cell.lblName.text = filterArr[indexPath.row].location
            cell.lblLocation.text = filterArr[indexPath.row].unit
            cell.lblPrice.text = filterArr[indexPath.row].startingPrice
            cell.imgVwSymbol.sd_setImage(with: URL(string: "\(imageBaseUrl)\(filterArr[indexPath.row].logo ?? "")"), placeholderImage: .placeholderImage())
            cell.imgVwSymbol.isHidden = false
            cell.constHeightPropertyList.constant = 40
            cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(filterArr[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
            cell.btnContactUs.tag = indexPath.row
            cell.btnContactUs.addTarget(self, action: #selector(actionContactUs), for: .touchUpInside)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collVwLocations {
            let label = UILabel(frame: CGRect.zero)
            label.text = arrSelectedLocation[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width+15, height: self.collVwLocations.frame.size.height)
        } else {
            return CGSize(width: self.collVwPropertyList.frame.size.width, height: 360)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView != collVwLocations {
            if let vc = ViewControllerHelper.getViewController(ofType: .PropertyDetailVC, StoryboardName: .Main) as? PropertyDetailVC {
                vc.propertyDetail = filterArr[indexPath.row]
                self.pushView(vc: vc)
            }
        }
    }
    @objc func actionContactUs(_ sender: UIButton) {
        
        if let vc = ViewControllerHelper.getViewController(ofType: .ContactUsVC, StoryboardName: .Main) as? ContactUsVC {
            vc.name = filterArr[sender.tag].agent?.name ?? ""
            vc.image = filterArr[sender.tag].agent?.images ?? ""
            vc.designation = filterArr[sender.tag].agent?.designation ?? ""
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            //vc.reraNo = filterArr[sender.tag].agent?.dldPermitNumber
            
            vc.filterComplDelegate = {
                val, msg in
                if let vc2 = ViewControllerHelper.getViewController(ofType: .AlertPopUpVC, StoryboardName: .Main) as? AlertPopUpVC {
                    vc2.modalPresentationStyle = .overFullScreen
                    vc2.modalTransitionStyle = .crossDissolve
                    if val {
                        vc2.titleStr = CommonMessage.CONFIRMATION_MSG
                        vc2.descrp = CommonMessage.THANK_FOR_REACHING
                    } else {
                        if msg == CommonError.INTERNET {
                            vc2.titleStr = CommonMessage.NO_INTERNET_CONNECTION
                            vc2.descrp = CommonMessage.INTERNET_RETRY
                        } else {
                            vc2.titleStr = CommonMessage.ALERT
                            vc2.descrp = msg
                        }
                    }
                    self.present(vc2, animated: true)
                }
            }
            self.present(vc, animated: true)
        }
    }
    @objc func actionCross(_ sender: UIButton) {
        self.arrSelectedLocation.remove(at: sender.tag)
        if arrSelectedLocation.count == 0 {
            cnstCollVwLocation.constant = 0
            filterArr = arrProperty
        }
        
        if !isFilter {
            filterArr = []
        }
        for i in arrSelectedLocation {
            for j in arrProperty {
                if j.location?.contains(i) == true {
                    filterArr.append(j)
                }
            }
        }
        var uniqueItems = Set<DataItemModel>()
        
        for item in filterArr {
            uniqueItems.insert(item)
        }
        filterArr = Array(uniqueItems)
        
        collVwPropertyList.reloadData()
        collVwLocations.reloadData()
    }
}


extension PropertyListVC: UITextFieldDelegate{ //UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.showShortDropDown(textFeild: textField, data: arrLocation)
//        let _ = ImagePickerManager().pickImage(self) { img in
//            self.image = img
//        }
        return false
    }
    
    func showShortDropDown(textFeild:UITextField,data:[String]){
        DispatchQueue.main.async {
            textFeild.resignFirstResponder()
            
            self.dropDown.anchorView = textFeild.plainView
            self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
            
            self.dropDown.dataSource = data
            
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                if !arrSelectedLocation.contains(item) {
                    arrSelectedLocation.append(item)
                    if !isFilter {
                        filterArr = []
                    }
                    for i in arrSelectedLocation {
                        for j in arrProperty {
                            if j.location?.contains(i) == true {
                                filterArr.append(j)
                            }
                        }
                    }
                    var uniqueItems = Set<DataItemModel>()
                    
                    for item in filterArr {
                        uniqueItems.insert(item)
                    }
                    filterArr = Array(uniqueItems)
                    
                    collVwLocations.reloadData()
                    collVwPropertyList.reloadData()
                }
                if arrSelectedLocation.count > 0 {
                    cnstCollVwLocation.constant = 55
                }
            }
            self.dropDown.show()
        }
    }
}
