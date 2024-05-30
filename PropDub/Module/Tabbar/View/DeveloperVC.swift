//
//  DeveloperVC.swift
//  PropDub
//
//  Created by acme on 23/05/24.
//

import UIKit

class DeveloperVC: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var collVwDevelopers: UICollectionView!
    //MARK: - Lifecycle method
    override func viewDidLoad() {
        super.viewDidLoad()
        collVwDevelopers.registerNib(nibName: "NewDevelopmentsCVC")
    }
}

extension DeveloperVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Proxy.shared.arrDeveloperList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collVwDevelopers.dequeueReusableCell(withReuseIdentifier: "NewDevelopmentsCVC", for: indexPath) as! NewDevelopmentsCVC
        cell.lblTitle.text = Proxy.shared.arrDeveloperList?[indexPath.row].name
        cell.imgVwProperty.sd_setImage(with: URL(string: "\(imageBaseUrl)\(Proxy.shared.arrDeveloperList?[indexPath.row].images ?? "")"), placeholderImage: .placeholderImage())
        cell.imgVwSymbol.sd_setImage(with: URL(string: "\(imageBaseUrl)\(Proxy.shared.arrDeveloperList?[indexPath.row].logo ?? "")"), placeholderImage: .placeholderImage())
        cell.lblDate.text = "View Details"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collVwDevelopers.frame.size.width, height: 170)
    }
}
