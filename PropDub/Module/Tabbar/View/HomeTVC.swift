//
//  HomeeTVC.swift
//  PropDub
//
//  Created by acme on 22/05/24.
//

import UIKit
import SDWebImage

class HomeTVC: UITableViewCell {
    //MARK: - @IBOutlets
    @IBOutlet weak var vwCalculator: UIView!
    @IBOutlet weak var collVwHome: UICollectionView!
    //MARK: - Variables
    var index = Int()
    var arrPropertyType = ["All", "Residential", "Commercial", "Off Plan", "Secondary Market"]
    var arrPremiumList = [DataItemModel]()
    var arrFreshFinds = [DataItemModel]()
    var arrTrendingList = [DataItemModel]()
    var arrDeveloperList = [DeveloperModel]()
    var view = UIViewController()
    //MARK: - Lifecycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
        collVwHome.delegate = self
        collVwHome.dataSource = self
        collVwHome.registerNib(nibName: "PropertyTypeCVC")
        collVwHome.registerNib(nibName: "FeaturedPropertyCVC")
        collVwHome.registerNib(nibName: "ExclusiveCVC")
        collVwHome.registerNib(nibName: "NewDevelopmentsCVC")
    }
    //MARK: - Custom methods
    func reloadData(_ section: Int, arrPremiumList: [DataItemModel], arrFreshFinds: [DataItemModel], arrExclusive: [DataItemModel], arrDeveloperList: [DeveloperModel], vc: UIViewController) {
        index = section
        view = vc
        self.arrPremiumList = arrPremiumList
        self.arrFreshFinds = arrFreshFinds
        self.arrTrendingList = arrExclusive
        self.arrDeveloperList = arrDeveloperList
        collVwHome.reloadData()
    }
}

extension HomeTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        index == 0 ? arrPropertyType.count : index == 1 ? self.arrPremiumList.count : index == 2 ? self.arrFreshFinds.count : index == 3 ? arrDeveloperList.count : arrTrendingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyTypeCVC", for: indexPath) as! PropertyTypeCVC
            cell.lblPropertyType.text = arrPropertyType[indexPath.row]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedPropertyCVC", for: indexPath) as! FeaturedPropertyCVC
            cell.lblTitle.text = arrPremiumList[indexPath.row].name
            cell.lblLocation.text = arrPremiumList[indexPath.row].location
            cell.lblPrice.text = arrPremiumList[indexPath.row].startingPrice
            cell.imgVwFeatureProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrPremiumList[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
            cell.imgVwSymbol.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrPremiumList[indexPath.row].logo ?? "")"), placeholderImage: .placeholderImage())
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExclusiveCVC", for: indexPath) as! ExclusiveCVC
            cell.lblName.text = arrFreshFinds[indexPath.row].location
            cell.lblLocation.text = arrFreshFinds[indexPath.row].unit
            cell.lblPrice.text = arrFreshFinds[indexPath.row].startingPrice
            cell.imgVwSymbol.isHidden = true
            cell.constHeightPropertyList.constant = 0
            cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrFreshFinds[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyTypeCVC", for: indexPath) as! PropertyTypeCVC
            cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrDeveloperList[indexPath.row].logo ?? "")"), placeholderImage: .placeholderImage())
            cell.lblDevelopers.isHidden = false
            cell.lblPropertyType.isHidden = true
            cell.imgVwBackground.isHidden = false
            cell.lblDevelopers.text = arrDeveloperList[indexPath.row].name
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewDevelopmentsCVC", for: indexPath) as! NewDevelopmentsCVC
            cell.lblTitle.text = arrTrendingList[indexPath.row].name
            cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrTrendingList[indexPath.row].image ?? "")"), placeholderImage: .placeholderImage())
            cell.imgVwSymbol.sd_setImage(with: URL(string: "\(imageBaseUrl)\(arrTrendingList[indexPath.row].logo ?? "")"), placeholderImage: .placeholderImage())
            cell.lblDate.text = "Updated on \(Proxy.shared.convertDateFormat(date: arrTrendingList[indexPath.row].createdAt ?? "", getFormat: "dd MMM yy", dateFormat: "yyyy-MM-ddTHH:mm:ss.000000Z"))"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: 120, height: self.collVwHome.frame.size.height)
        case 1:
            return CGSize(width: self.collVwHome.frame.size.width/1.2, height: self.collVwHome.frame.size.height)
        case 2:
            return CGSize(width: self.collVwHome.frame.size.width, height: self.collVwHome.frame.size.height)
        case 3:
            return CGSize(width: self.collVwHome.frame.size.width/2.5, height: self.collVwHome.frame.size.height)
        case 4:
            return CGSize(width: self.collVwHome.frame.size.width, height: self.collVwHome.frame.size.height)
        default:
            return .zero
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch index {
        case 0:
            if let vc = ViewControllerHelper.getViewController(ofType: .PropertyListVC, StoryboardName: .Main) as? PropertyListVC {
                vc.type = indexPath.row
                view.pushView(vc: vc)
            }
        case 1:
            if let vc = ViewControllerHelper.getViewController(ofType: .PropertyDetailVC, StoryboardName: .Main) as? PropertyDetailVC {
                vc.propertyDetail = arrPremiumList[indexPath.row]
                view.pushView(vc: vc)
            }
        default:
            break
        }
    }
}
