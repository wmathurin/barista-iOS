//
//  ProductConfigureViewController.swift
//  Consumer
//
//  Created by David Vieser on 2/7/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ProductConfigureViewController: UIViewController {

    var product: Product? 
    var category: Category?
    var categoryAttributes: [CategoryAttribute?] = []
    let sizeCellName = "SizeCell"
    let SMLCellName = "SMLCell"
    let listCell = "ListCell"
    
    @IBOutlet weak var productConfigureContainerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attributeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attributeTableView.tableFooterView = UIView()
        productNameLabel?.text = product?.name
        productImageView.loadImageUsingCache(withUrl: product?.iconImageURL)
        productImageView.round()
        productImageView.layer.borderColor = UIColor.white.cgColor
        productImageView.layer.borderWidth = 3
        
        categoryAttributes = CategoryAttributeStore.instance.attributes(forCategory: category)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productConfigureContainerView.mask(offset: 50, direction: .convex, side: .top)
    }
    
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {}
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProductConfigureViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryAttributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "temp")
        
        if let attribute: CategoryAttribute = categoryAttributes[indexPath.row] {
            cell.textLabel?.text = attribute.name
//        let cellIdentifier = "FeaturedProductCell"
//
//        // Dequeue or create a cell of the appropriate type.
//        let cell: FeaturedProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeaturedProductTableViewCell
//
//        // Configure the cell to show the data.
//        if let product: Product = featuredProducts[indexPath.row] {
//            cell.productName = product.name
//            cell.productImageURL = indexPath.row % 2 == 0 ? product.featuredImageRightURL : product.featuredImageLeftURL
//        }
        
        }
        return cell
    }
}
