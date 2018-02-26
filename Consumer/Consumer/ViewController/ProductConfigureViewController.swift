//
//  ProductConfigureViewController.swift
//  Consumer
//
//  Created by David Vieser on 2/7/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ProductConfigureViewController: UIViewController {

    var orderItem: OrderItem?
    var product: Product?
    var category: Category?
    var productOptions: [ProductOption] = []
    var categoryAttributes: [CategoryAttribute?] = []
    
    fileprivate static let curveMaskHeight:CGFloat = 50.0
    fileprivate var gradientView = GradientView()
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productConfigureContainerView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var attributeTableView: UITableView!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        let gradientLayer = self.gradientView.layer as! CAGradientLayer
        gradientLayer.colors = [Theme.productConfigTopBgGradColor.cgColor, Theme.productConfigBottomBgGradColor.cgColor]
        self.productConfigureContainerView.insertSubview(self.gradientView, at: 0)

        self.productNameLabel.font = Theme.productConfigItemNameFont
        self.productNameLabel.textColor = Theme.productConfigTextColor

        self.productPriceLabel.font = Theme.productConfigItemPriceFont
        self.productPriceLabel.textColor = Theme.productConfigTextColor

        self.productDescriptionLabel.font = Theme.productConfigItemDescriptionFont
        self.productDescriptionLabel.textColor = Theme.productConfigTextColor

        self.attributeTableView.backgroundColor = UIColor.clear
        self.attributeTableView.separatorColor = Theme.productConfigTableSeparatorColor
        self.attributeTableView.separatorInset = UIEdgeInsets.zero
        self.attributeTableView.register(ProductConfigureTableViewCell.self, forCellReuseIdentifier: "itemCell")
        self.attributeTableView.delegate = self
        self.attributeTableView.dataSource = self
        self.attributeTableView.estimatedRowHeight = 40.0
        self.attributeTableView.rowHeight = UITableViewAutomaticDimension
        self.attributeTableView.tableFooterView = UIView()
        
        self.dividerView.backgroundColor = Theme.productConfigDividerColor
        
        self.addToCartButton.backgroundColor = Theme.productConfigAddToCartColor
        self.addToCartButton.setTitleColor(Theme.cartAddButtonTextColor, for: .normal)
        self.addToCartButton.titleLabel?.font = Theme.productConfigButtonFont
        
        self.cancelButton.backgroundColor = Theme.productConfigCancelAddToCartColor
        self.cancelButton.titleLabel?.font = Theme.productConfigButtonFont
        self.cancelButton.setTitleColor(Theme.cartCancelButtonTextColor, for: .normal)
        
        self.productImageView.clipsToBounds = true
        self.productImageView.loadImageUsingCache(withUrl: self.product?.iconImageURL)
        self.productImageView.layer.borderColor = UIColor.white.cgColor
        self.productImageView.layer.borderWidth = 3
        
        self.gradientView.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor).isActive = true
        self.gradientView.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor).isActive = true
        self.gradientView.topAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor).isActive = true
        self.gradientView.bottomAnchor.constraint(equalTo: self.productConfigureContainerView.bottomAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        
        self.productImageView.round()
        
        self.productNameLabel.text = self.product?.name
        self.productPriceLabel.text = "Free" // TODO pull from pricebook
        self.productDescriptionLabel.text = "Description lorem ipsum dolor sit amet, consectur adispicing elit. Aliquam convallis tortor vel risus tincidunt, nec commodo." // TODO pull from product description
        
        self.categoryAttributes = CategoryAttributeStore.instance.attributes(for: category)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.productConfigureContainerView.mask(offset: ProductConfigureViewController.curveMaskHeight, direction: .convex, side: .top)
    }
    
    @IBAction func didPressCloseButton(_ sender: UIButton) {
        self.cancelOrdering()
    }
    
    @IBAction func didPressFavoriteButton(_ sender: UIButton) {
    }
    
    @IBAction func didPressAddToCartButton(_ sender: UIButton) {
    }
    
    @IBAction func didPressCancelButton(_ sender: UIButton) {
        self.cancelOrdering()
    }
    
    fileprivate func cancelOrdering() {
        self.dismiss(animated: true) {}
    }
}

extension ProductConfigureViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productOptions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = self.attributeTableView.separatorColor
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ProductConfigureTableViewCell
        var controlStyle: ProductConfigureCellControlType = .unknown
        
        var type: ProductionOptionType = .integer
        let option = self.productOptions[indexPath.row]
        cell.name = option.productName
        cell.maxValue = option.maxQuantity
        cell.minValue = option.minQuantity
        cell.currentValue = option.defaultQuantity
        
        if let t = option.optionType {
            type = t
        }
        
        switch type {
        case .integer:
            controlStyle = .increment
        case .slider:
            controlStyle = .slider
        case .picklist, .multiselect:
            controlStyle = .list
        }
        cell.controlStyle = controlStyle
        
//        if let attribute: CategoryAttribute = self.categoryAttributes[indexPath.row], let attributeType = attribute.attributeType {
//
//            cell.name = attribute.name
//            cell.imageURL = attribute.iconImageURL
//
//            switch attributeType {
//            case .slider:
//                controlStyle = .slider
//                maxValue = 2
//            case .integer:
//                controlStyle = .increment
//                maxValue = 3
//            case .picklist, .multiselect:
//                controlStyle = .list
//                let values = CategoryAttributeValueStore.instance.attributes(for: attribute)
//                let names = values.map({ return $0.name ?? "" })
//                cell.listItems = names
//            }
//
//
//            cell.controlStyle = controlStyle
//
//        }
        cell.controlClosure = { (value) in
            print("updated value to: \(value)")
            // todo update value on order item
        }
        cell.pickListClosure = { (index, name) in
            print("selected list item: \(name) at index: \(index)")
            // todo update value on order item
        }
        return cell
    }
}
