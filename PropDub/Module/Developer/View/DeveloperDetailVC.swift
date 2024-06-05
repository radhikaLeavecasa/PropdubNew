//
//  DeveloperDetailVC.swift
//  PropDub
//
//  Created by acme on 29/05/24.
//

import UIKit

class DeveloperDetailVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var cnstStackVwHeight: NSLayoutConstraint!
    @IBOutlet weak var vwInsideStackVw: UIView!
    @IBOutlet weak var constTblVwHeight: NSLayoutConstraint!
    @IBOutlet weak var imgVwDevelopment: UIImageView!
    @IBOutlet weak var lblHeaderPointer: UILabel!
    @IBOutlet weak var imgVwSymbol: UIImageView!
    @IBOutlet weak var collVwDeveloper: UICollectionView!
    @IBOutlet weak var collVwOtherProperties: UICollectionView!
    @IBOutlet weak var tblVwPropDetail: UITableView!
    @IBOutlet weak var lblDevelopmentName: UILabel!
    @IBOutlet weak var collVwPropDetail: UICollectionView!
    //MARK: - Variables
    var developerDetail: DeveloperModel?
    var arrDevelopers = [DeveloperModel]()
    var arrPropByDeveloper: [DataItemModel]?
    var arrPointers = [String]()
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        arrDevelopers = Proxy.shared.arrDeveloperList ?? []
        if let index = Proxy.shared.arrDeveloperList?.firstIndex(where: {$0.id == developerDetail?.id}) {
            arrDevelopers.remove(at: index)
        }
        
        arrPropByDeveloper = Proxy.shared.arrPropertyList?.filter({$0.developer?.id == developerDetail?.id})
        
        let inputString = developerDetail?.pointers ?? ""

        let regexPattern = #"(\d+\..*?)(?=\d+\.|$)"#

        // Create a regular expression object
        guard let regex = try? NSRegularExpression(pattern: regexPattern) else {
            fatalError("Failed to create regex")
        }

        // Find all matches in the input string
        let matches = regex.matches(in: inputString, range: NSRange(inputString.startIndex..., in: inputString))

        // Construct the display text
        var displayText = ""
        for (index, match) in matches.enumerated() {
            let range = Range(match.range(at: 1), in: inputString)!
            let line = "\(inputString[range])"
            displayText += line
            if index < matches.count - 1 {
                displayText += "\n"
            }
        }
        tblVwPropDetail.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)

        arrPointers = displayText.components(separatedBy: "\n")
        

        collVwDeveloper.registerNib(nibName: "PropertyTypeCVC")
        collVwOtherProperties.registerNib(nibName: "ExclusiveCVC")
        lblDevelopmentName.text = developerDetail?.name
        imgVwDevelopment.sd_setImage(with: URL(string: "\(imageBaseUrl)\(developerDetail?.images ?? "")"))
        imgVwSymbol.sd_setImage(with: URL(string: "\(imageBaseUrl)\(developerDetail?.logo ?? "")"))
        lblHeaderPointer.text = developerDetail?.fHeading
        tblVwPropDetail.reloadData()
        collVwDeveloper.reloadData()
        collVwOtherProperties.reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "contentSize" {
            if object is UITableView {
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    self.constTblVwHeight.constant = newSize.height
                }
            }
        }
    }
    
    //MARK: - @IBActions
    @IBAction func actionBack(_ sender: Any) {
        popView()
    }
}

extension DeveloperDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collVwDeveloper:
            return arrDevelopers.count
        case collVwOtherProperties:
            return arrPropByDeveloper?.count ?? 0
        default:
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case collVwDeveloper:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyTypeCVC", for: indexPath) as! PropertyTypeCVC
            cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrDevelopers[indexPath.row].logo ?? "")"), placeholderImage: .placeholderImage())
            cell.lblDevelopers.isHidden = false
            cell.backgroundColor = .clear
            cell.lblPropertyType.isHidden = true
            cell.imgVwBackground.isHidden = false
            cell.lblDevelopers.text = arrDevelopers[indexPath.row].name
            return cell
        case collVwOtherProperties:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExclusiveCVC", for: indexPath) as! ExclusiveCVC
            cell.backgroundColor = .clear
            cell.lblName.text = arrPropByDeveloper?[indexPath.row].location
            cell.lblLocation.text = arrPropByDeveloper?[indexPath.row].unit
            cell.lblPrice.text = arrPropByDeveloper?[indexPath.row].startingPrice
            cell.imgVwSymbol.isHidden = true
            cell.constHeightPropertyList.constant = 0
            cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrPropByDeveloper?[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactOptionsCVC", for: indexPath) as! ContactOptionsCVC
            cell.lblTitle.text = indexPath.row == 0 ? "\(developerDetail?.exp ?? "")\nYears Of Experience" : indexPath.row == 1 ? "\(developerDetail?.emp ?? "")\nEmployees" : indexPath.row == 2 ? "\(developerDetail?.hq ?? "")\nHeadquaters" : "\(developerDetail?.estb ?? "")\nEstablished In"
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case collVwDeveloper:
            return CGSize(width: self.collVwDeveloper.frame.size.width/2.5, height: self.collVwDeveloper.frame.size.height)
        case collVwOtherProperties:
            return CGSize(width: self.collVwOtherProperties.frame.size.width, height: self.collVwOtherProperties.frame.size.height)
        default:
            return CGSize(width: self.collVwPropDetail.frame.size.width/2, height: self.collVwPropDetail.frame.size.height/2)
        }
    }
}

extension DeveloperDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrPointers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyTVC", for: indexPath) as! PropertyTVC
        cell.lblOne.text = arrPointers[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
