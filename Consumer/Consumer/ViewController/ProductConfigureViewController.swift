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
    let integerCellName = "IntegerCell"
    let listCellName = "ListCell"
    
    @IBOutlet weak var productConfigureContainerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attributeTableView: UITableView!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        attributeTableView.tableFooterView = UIView()
        productNameLabel?.text = product?.name
        productImageView.loadImageUsingCache(withUrl: product?.iconImageURL)
        productImageView.round()
        productImageView.layer.borderColor = UIColor.white.cgColor
        productImageView.layer.borderWidth = 3
        
        categoryAttributes = CategoryAttributeStore.instance.attributes(for: category)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productConfigureContainerView.mask(offset: 50, direction: .convex, side: .top)
    }
    
    @IBAction func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {}
    }
    @IBAction func addToCartButtonTouchUpInside(_ sender: Any) {
    }

}

extension ProductConfigureViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryAttributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let attribute: CategoryAttribute = categoryAttributes[indexPath.row], let attributeType = attribute.attributeType {
            var cellName: String {
                switch attributeType {
                case .size:
                    return sizeCellName
                case .integer:
                    return integerCellName
                case .list:
                    return listCellName
                }
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! BaseTableViewCell
            cell.name = attribute.name
            cell.imageURL = attribute.iconImageURL
            cell.imageView?.image = UIImage()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CellSelectedProtocol,
            let attribute = categoryAttributes[indexPath.row] {
            cell.selected(attribute: attribute)
        }
    }
}
