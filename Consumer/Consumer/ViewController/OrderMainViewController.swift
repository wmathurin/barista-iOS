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
    
    fileprivate var cartButton:UIButton!
    
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
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        featuredItemImageView.mask(offset: 50, direction: .convex, side: .bottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredItemLabel.textColor = UIColor.white
        featuredItemLabel.text = ""

        featuredProductNameLabel.textColor = UIColor.white
        featuredProductNameLabel.text = ""
        
        let safe = self.view.safeAreaLayoutGuide
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "cart_unselected"), for: .normal)
        button.addTarget(self, action: #selector(didPressCartButton), for: .touchUpInside)
        button.titleLabel?.font = Theme.cartButtonFont
        button.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(button)
        button.topAnchor.constraint(equalTo: safe.topAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: safe.rightAnchor, constant: -8).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor, multiplier: 1.0).isActive = true
        button.alpha = 0.0
        self.cartButton = button

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
        
        OrderStore.instance.syncDown(completion: { (orderSyncState) in
            if let complete = orderSyncState?.isDone(), complete == true {
                OrderItemStore.instance.syncDown(completion: { (itemSyncState) in
                    if let itemComplete = itemSyncState?.isDone(), itemComplete == true {
                        let records = OrderStore.instance.records()
                        if let current = records.first {
                            if current.orderStatus() == .pending {
                                let items = OrderItemStore.instance.items(from: current)
                                var count:Int = 0
                                for item in items {
                                    if let quantity = item.quantity {
                                        count = count + quantity
                                    }
                                }
                                DispatchQueue.main.async {
                                    self.cartButton.alpha = 1.0
                                    self.cartButton.setTitle("\(count)", for: .normal)
                                }
                                
                            }
                        }
                    }
                })
            }
        })
        
        
    }
    
    @objc func didPressCartButton() {
        guard let order = OrderStore.instance.pendingOrder() else {return}
        let cart = CartViewController(order: order, orderStore: OrderStore.instance, itemStore:OrderItemStore.instance)
        self.navigationController?.pushViewController(cart, animated: true)
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
