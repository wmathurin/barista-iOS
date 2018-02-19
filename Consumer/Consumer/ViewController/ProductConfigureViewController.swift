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
    var product: Product
    var category: Category
    var categoryAttributes: [CategoryAttribute?] = []
    let sizeCellName = "SizeCell"
    let integerCellName = "IntegerCell"
    let listCellName = "ListCell"
    
    fileprivate static let curveMaskHeight:CGFloat = 50.0
    fileprivate var productImageView = UIImageView()
    fileprivate var gradientView = GradientView()
    fileprivate var productConfigureContainerView = UIView()
    fileprivate var productNameLabel = UILabel()
    fileprivate var productPriceLabel = UILabel()
    fileprivate var productDescriptionLabel = UILabel()
    fileprivate var favoriteButton = UIButton(type: .custom)
    fileprivate var closeButton = UIButton(type: .custom)
    fileprivate var attributeTableView = UITableView(frame: .zero, style: .plain)
    
    fileprivate var addToCartButton = UIButton(type: .custom)
    fileprivate var cancelButton = UIButton(type: .custom)
    
    fileprivate var expandedIndexPath:IndexPath?
    
    init(orderItem:OrderItem?, product:Product, category:Category) {
        self.orderItem = orderItem
        self.product = product
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(product:Product, category:Category) {
        self.init(orderItem: nil, product: product, category: category)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        self.gradientView.translatesAutoresizingMaskIntoConstraints = false
        let gradientLayer = self.gradientView.layer as! CAGradientLayer
        gradientLayer.colors = [Theme.productConfigTopBgGradColor.cgColor, Theme.productConfigBottomBgGradColor.cgColor]
        self.productConfigureContainerView.addSubview(self.gradientView)
        
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.favoriteButton.setImage(UIImage(named:"fav01"), for: .normal)
        self.favoriteButton.addTarget(self, action: #selector(didPressFavoriteButton), for: .touchUpInside)
        self.productConfigureContainerView.addSubview(self.favoriteButton)
        
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton.setImage(UIImage(named:"close01"), for: .normal)
        self.closeButton.addTarget(self, action: #selector(didPressCloseButton), for: .touchUpInside)
        self.productConfigureContainerView.addSubview(self.closeButton)
        
        self.productConfigureContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.productConfigureContainerView)
        
        self.productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productNameLabel.font = Theme.productConfigItemNameFont
        self.productNameLabel.textColor = Theme.productConfigTextColor
        self.productConfigureContainerView.addSubview(self.productNameLabel)
        
        self.productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productPriceLabel.font = Theme.productConfigItemPriceFont
        self.productPriceLabel.textColor = Theme.productConfigTextColor
        self.productConfigureContainerView.addSubview(self.productPriceLabel)
        
        self.productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productDescriptionLabel.font = Theme.productConfigItemDescriptionFont
        self.productDescriptionLabel.textColor = Theme.productConfigTextColor
        self.productDescriptionLabel.numberOfLines = 0
        self.productConfigureContainerView.addSubview(self.productDescriptionLabel)
        
        self.attributeTableView.translatesAutoresizingMaskIntoConstraints = false
        self.attributeTableView.backgroundColor = UIColor.clear
        self.attributeTableView.separatorColor = Theme.productConfigTableSeparatorColor
        self.attributeTableView.separatorInset = UIEdgeInsets.zero
        self.attributeTableView.register(ProductConfigureTableViewCell.self, forCellReuseIdentifier: "itemCell")
        self.attributeTableView.delegate = self
        self.attributeTableView.dataSource = self
        self.attributeTableView.estimatedRowHeight = 40.0
        self.attributeTableView.rowHeight = UITableViewAutomaticDimension
        self.attributeTableView.tableFooterView = UIView()
        self.productConfigureContainerView.addSubview(self.attributeTableView)
        
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = Theme.productConfigDividerColor
        self.productConfigureContainerView.addSubview(divider)
        
        self.addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        self.addToCartButton.backgroundColor = Theme.productConfigAddToCartColor
        self.addToCartButton.setTitleColor(Theme.cartAddButtonTextColor, for: .normal)
        self.addToCartButton.setTitle("ADD TO CART", for: .normal)
        self.addToCartButton.titleLabel?.font = Theme.productConfigButtonFont
        self.addToCartButton.addTarget(self, action: #selector(didPressAddToCartButton), for: .touchUpInside)
        self.productConfigureContainerView.addSubview(self.addToCartButton)
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.backgroundColor = Theme.productConfigCancelAddToCartColor
        self.cancelButton.setTitle("CANCEL", for: .normal)
        self.cancelButton.titleLabel?.font = Theme.productConfigButtonFont
        self.cancelButton.setTitleColor(Theme.cartCancelButtonTextColor, for: .normal)
        self.cancelButton.addTarget(self, action: #selector(didPressCloseButton), for: .touchUpInside)
        self.productConfigureContainerView.addSubview(self.cancelButton)
        
        self.productImageView.translatesAutoresizingMaskIntoConstraints = false
        self.productImageView.clipsToBounds = true
        self.productImageView.loadImageUsingCache(withUrl: self.product.iconImageURL)
        self.productImageView.layer.borderColor = UIColor.white.cgColor
        self.productImageView.layer.borderWidth = 3
        self.view.addSubview(self.productImageView)
        
        let safe = self.view.safeAreaLayoutGuide
        
        self.productConfigureContainerView.topAnchor.constraint(equalTo: safe.topAnchor, constant:30.0).isActive = true
        self.productConfigureContainerView.leftAnchor.constraint(equalTo: safe.leftAnchor).isActive = true
        self.productConfigureContainerView.rightAnchor.constraint(equalTo: safe.rightAnchor).isActive = true
        self.productConfigureContainerView.bottomAnchor.constraint(equalTo: safe.bottomAnchor).isActive = true
        
        self.gradientView.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor).isActive = true
        self.gradientView.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor).isActive = true
        self.gradientView.topAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor).isActive = true
        self.gradientView.bottomAnchor.constraint(equalTo: self.productConfigureContainerView.bottomAnchor).isActive = true
        
        self.productImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.productImageView.centerYAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor, constant:30).isActive = true
        self.productImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.22).isActive = true
        self.productImageView.heightAnchor.constraint(equalTo: self.productImageView.widthAnchor, multiplier: 1.0).isActive = true
        self.favoriteButton.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor, constant: 16.0).isActive = true
        self.favoriteButton.topAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor, constant:60.0).isActive = true
        self.closeButton.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor, constant: -16.0).isActive = true
        self.closeButton.centerYAnchor.constraint(equalTo: self.favoriteButton.centerYAnchor).isActive = true
        
        self.productNameLabel.centerXAnchor.constraint(equalTo: self.productConfigureContainerView.centerXAnchor).isActive = true
        self.productNameLabel.topAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor, constant:80.0).isActive = true
        self.productPriceLabel.centerXAnchor.constraint(equalTo: self.productConfigureContainerView.centerXAnchor).isActive = true
        self.productPriceLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor, constant:-2.0).isActive = true
        self.productDescriptionLabel.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor, constant:40.0).isActive = true
        self.productDescriptionLabel.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor, constant:-40.0).isActive = true
        self.productDescriptionLabel.topAnchor.constraint(equalTo: self.productPriceLabel.bottomAnchor, constant:14.0).isActive = true
        self.attributeTableView.topAnchor.constraint(equalTo: self.productDescriptionLabel.bottomAnchor, constant:38.0).isActive = true
        self.attributeTableView.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor).isActive = true
        self.attributeTableView.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor).isActive = true
        
        divider.topAnchor.constraint(equalTo: self.attributeTableView.bottomAnchor).isActive = true
        divider.leftAnchor.constraint(equalTo: safe.leftAnchor).isActive = true
        divider.rightAnchor.constraint(equalTo: safe.rightAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.cancelButton.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor).isActive = true
        self.cancelButton.topAnchor.constraint(equalTo: divider.bottomAnchor).isActive = true
        self.cancelButton.bottomAnchor.constraint(equalTo: self.productConfigureContainerView.bottomAnchor).isActive = true
        self.cancelButton.widthAnchor.constraint(equalTo: self.addToCartButton.widthAnchor, multiplier: 1.0).isActive = true
        self.cancelButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.addToCartButton.leftAnchor.constraint(equalTo: self.cancelButton.rightAnchor).isActive = true
        self.addToCartButton.topAnchor.constraint(equalTo: self.cancelButton.topAnchor).isActive = true
        self.addToCartButton.bottomAnchor.constraint(equalTo: self.cancelButton.bottomAnchor).isActive = true
        self.addToCartButton.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor).isActive = true
        
        self.view.layoutIfNeeded()
        
        self.productImageView.round()
        
        self.productNameLabel.text = self.product.name
        self.productPriceLabel.text = "Free" // TODO pull from pricebook
        self.productDescriptionLabel.text = "Description lorem ipsum dolor sit amet, consectur adispicing elit. Aliquam convallis tortor vel risus tincidunt, nec commodo." // TODO pull from product description
        
        categoryAttributes = CategoryAttributeStore.instance.attributes(forCategory: category)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.productConfigureContainerView.mask(offset: ProductConfigureViewController.curveMaskHeight, direction: .convex, side: .top)
    }
    
    @objc func didPressCloseButton() {
        self.dismiss(animated: true) {}
    }
    
    @objc func didPressAddToCartButton() {
        //todo
    }
    
    @objc func didPressFavoriteButton() {
        //todo
    }

}

extension ProductConfigureViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryAttributes.count
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
        print("didSelect")
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var controlStyle: ProductConfigureCellControlType = .unknown
        var maxValue: Int = 0
        if let attribute: CategoryAttribute = self.categoryAttributes[indexPath.row], let attributeType = attribute.attributeType {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ProductConfigureTableViewCell
            cell.name = attribute.name
            cell.imageURL = attribute.iconImageURL
            
            switch attributeType {
            case .size:
                controlStyle = .slider
                maxValue = 2
            case .integer:
                controlStyle = .increment
                maxValue = 3
            case .list:
                controlStyle = .list
                cell.listItems = ["Item 1", "Item 2", "Item 3"]
            }
            
            
            cell.controlStyle = (controlStyle, maxValue)
            cell.controlClosure = { (value) in
                print("updated value to: \(value)")
                // todo update value on order item
            }
            return cell
        }
        return UITableViewCell()
    }
}
