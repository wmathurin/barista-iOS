//
//  OrderMainViewController.swift
//  Consumer
//
//  Created by David Vieser on 1/31/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit
import CoreGraphics

class OrderMainViewController: UIViewController {
    
    @IBOutlet weak var featuredItemImageView: UIImageView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let productSegue = "ProductSegue"
    
    override func loadView()
    {
        super.loadView()
        
        CategoryStore.instance.syncDown { (syncState) in
            DispatchQueue.main.async(execute: {
                self.categoryCollectionView.reloadData()
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        featuredItemImageView.mask(curveHeight: 50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController: ProductViewController = segue.destination as? ProductViewController,
            let category: Category = sender as? Category {
            destinationViewController.category = category
        }
    }
}

extension OrderMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(CategoryStore.instance.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "ItemCell"
        
        // Dequeue or create a cell of the appropriate type.
        let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        let image = UIImage(named: "icon.png")
        cell.categoryImageView.image = image
        
        // Configure the cell to show the data.
        let record: Category = CategoryStore.instance.getRecord(index: indexPath.item)
        cell.categoryLabel.text = record.name
        
        // This adds the arrow to the right hand side.
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: productSegue, sender: CategoryStore.instance.getRecord(index: indexPath.item))
    }
}
