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
    @IBOutlet weak var featuredItemLabel: UILabel!
    @IBOutlet weak var featuredProductNameLabel: UILabel!
    
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
        featuredItemImageView.mask(curveHeight: -50)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredItemLabel.textColor = UIColor.white
        featuredItemLabel.text = ""

        featuredProductNameLabel.textColor = UIColor.white
        featuredProductNameLabel.text = ""

        ProductStore.instance.syncDown { (syncState) in
            let featuredProducts: [Product] = ProductStore.instance.featuredProducts()
            if let featuredProduct: Product = featuredProducts.first, let firstFeaturedProdcutURL = featuredProduct.featuredImageRightURL {
                DispatchQueue.main.async(execute: {
                    self.featuredItemImageView.loadImageUsingCache(withUrl: firstFeaturedProdcutURL)
                    self.featuredItemLabel.text = "FEATURED ITEM:"
                    self.featuredProductNameLabel.text = featuredProduct.name
                })
            }
        }
        
        ProductCategoryAssociationStore.instance.syncDown { (syncState) in
        }
        
        CategoryAttributeStore.instance.syncDown{ (syncState) in
        }
        
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
        
        // Configure the cell to show the data.
        let category = CategoryStore.instance.record(index: indexPath.item)
        cell.categoryName = category.name
        cell.categoryImageURL = category.iconImageURL
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: productSegue, sender: CategoryStore.instance.record(index: indexPath.item))
    }
}
