//
//  HomeVC.swift
//  LeaveCasa
//
//  Created by acme on 08/09/22.
//

import UIKit

//enum HomeType{
//    case Banner
//    case Popurlar
//}

class HomeVC: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var vwPropertyAgent: [UIView]!
    @IBOutlet weak var lblAgent: UILabel!
    @IBOutlet weak var imgVwAgent: UIImageView!
    @IBOutlet weak var lblProperty: UILabel!
    @IBOutlet weak var imgVwProperty: UIImageView!
    @IBOutlet var btnPropertAgent: [UIButton]!
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var tblVwHome: UITableView!
    
    //MARK: - Variables
    var arrHeader = [("Property","Type"), ("Premier", "Listing"), ("Fresh", "Finds"), ("Discover Our", "Developers"), ("Most Trending projects in","Dubai")]
    var viewModel = HomeVM()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblVwHome.register(UINib(nibName: "HomeTVC", bundle: nil), forCellReuseIdentifier: "HomeTVC")
        tblVwHome.register(UINib(nibName: "HomeHeaderNewXIB", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeHeaderNewXIB")
        viewModel.getHomeApi {
            self.tblVwHome.reloadData()
        }
        viewModel.developerHomeApi { [self] in
            Proxy.shared.arrDeveloperList = self.viewModel.arrDeveloperList
            self.tblVwHome.reloadData()
        }
    }
    
    //MARK: - @IBAction
    @IBAction func actionPropertyAgent(_ sender: UIButton) {
        for btn in btnPropertAgent {
            vwPropertyAgent[btn.tag].backgroundColor = sender.tag == btn.tag ? .black : .clear
            if sender.tag == btn.tag {
                if sender.tag == 0 {
                    lblAgent.textColor = .darkGray
                    lblProperty.textColor = .white
                    imgVwAgent.image = UIImage(named: "ic_agent")
                    imgVwProperty.image = UIImage(named: "ic_property_selected")
                } else {
                    lblProperty.textColor = .darkGray
                    lblAgent.textColor = .white
                    imgVwAgent.image = UIImage(named: "ic_agent_selected")
                    imgVwProperty.image = UIImage(named: "ic_property_unselected")
                }
            }
        }
    }
    @IBAction func actionProfile(_ sender: Any) {
        let vc = ViewControllerHelper.getViewController(ofType: .ProfileVC, StoryboardName: .Main) as! ProfileVC
        self.pushView(vc: vc)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        arrHeader.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVwHome.dequeueReusableCell(withIdentifier: "HomeTVC") as! HomeTVC
        cell.collVwHome.isHidden = indexPath.section == 5
        cell.vwCalculator.isHidden = indexPath.section != 5
        if indexPath.section != 5 {
            cell.reloadData(indexPath.section, arrPremiumList: viewModel.arrPremiumList, arrFreshFinds: viewModel.arrFreshFinds, arrExclusive: viewModel.arrTrendingList, arrDeveloperList: viewModel.arrDeveloperList ?? [], vc: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 5 {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeaderNewXIB().identifire) as! HomeHeaderNewXIB
            view.lblTitle.text = arrHeader[section].0
            view.lblTitleTwo.text = arrHeader[section].1
            view.vwAllOne.tag = section
            view.vwAllOne.isHidden = section == 0
            view.vwAllOne.addTarget(self, action: #selector(actionViewAll), for: .touchUpInside)
            return view
        } else {
            let vw = UIView()
            return vw
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 5 ? 0 : 30
    }
    @objc func actionViewAll(_ sender: UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 130
        case 1:
            return 160
        case 2:
            return 330
        case 3  :
            return 150
        case 4:
            return 170
        default:
            return 230
        }
    }
}
