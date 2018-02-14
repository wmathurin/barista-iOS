//
//  ProductConfigureViewController.swift
//  Consumer
//
//  Created by David Vieser on 2/7/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ProductConfigureViewController: UIViewController {

    var product: Product
    var category: Category
    var categoryAttributes: [CategoryAttribute?] = []
    let sizeCellName = "SizeCell"
    let integerCellName = "IntegerCell"
    let listCellName = "ListCell"
    
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
    
    init(product:Product, category:Category) {
        self.product = product
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.productConfigureContainerView.addSubview(self.favoriteButton)
        
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.productConfigureContainerView.addSubview(self.closeButton)
        
        self.productConfigureContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.productConfigureContainerView.backgroundColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.0, alpha: 0.1)
        self.view.addSubview(self.productConfigureContainerView)
        
        self.gradientView.translatesAutoresizingMaskIntoConstraints = false
        let gradientLayer = self.gradientView.layer as! CAGradientLayer
        gradientLayer.colors = [Theme.productConfigTopBgGradColor.cgColor, Theme.productConfigBottomBgGradColor.cgColor]
        self.productConfigureContainerView.addSubview(self.gradientView)
        
        self.productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productNameLabel.textColor = Theme.productConfigTextColor
        self.productConfigureContainerView.addSubview(self.productNameLabel)
        
        self.productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productPriceLabel.textColor = Theme.productConfigTextColor
        self.productConfigureContainerView.addSubview(self.productPriceLabel)
        
        self.productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.productDescriptionLabel.textColor = Theme.productConfigTextColor
        self.productDescriptionLabel.numberOfLines = 0
        self.productConfigureContainerView.addSubview(self.productDescriptionLabel)
        
        self.attributeTableView.translatesAutoresizingMaskIntoConstraints = false
        self.attributeTableView.backgroundColor = UIColor.clear
        self.attributeTableView.separatorColor = UIColor.clear
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
        self.addToCartButton.setTitle("ADD TO CART", for: .normal)
        self.productConfigureContainerView.addSubview(self.addToCartButton)
        
        self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.cancelButton.backgroundColor = Theme.productConfigCancelAddToCartColor
        self.productConfigureContainerView.addSubview(self.cancelButton)
        
        self.productImageView.translatesAutoresizingMaskIntoConstraints = false
        self.productImageView.clipsToBounds = true
        self.productImageView.loadImageUsingCache(withUrl: self.product.iconImageURL)
        self.productImageView.layer.borderColor = UIColor.white.cgColor
        self.productImageView.layer.borderWidth = 3
        self.view.addSubview(self.productImageView)
        
        self.productConfigureContainerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant:100.0).isActive = true
        self.productConfigureContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.productConfigureContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.productConfigureContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        gradientView.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor).isActive = true
        gradientView.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor).isActive = true
        gradientView.topAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.productConfigureContainerView.bottomAnchor).isActive = true
        
        self.productImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.productImageView.centerYAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor).isActive = true
        self.favoriteButton.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor, constant: 16.0).isActive = true
        self.favoriteButton.topAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor, constant:50.0).isActive = true
        self.closeButton.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor, constant: -16.0).isActive = true
        self.closeButton.centerYAnchor.constraint(equalTo: self.favoriteButton.centerYAnchor).isActive = true
        
        self.productNameLabel.centerXAnchor.constraint(equalTo: self.productConfigureContainerView.centerXAnchor).isActive = true
        self.productNameLabel.topAnchor.constraint(equalTo: self.productConfigureContainerView.topAnchor, constant:100.0).isActive = true
        self.productPriceLabel.centerXAnchor.constraint(equalTo: self.productConfigureContainerView.centerXAnchor).isActive = true
        self.productPriceLabel.topAnchor.constraint(equalTo: self.productNameLabel.bottomAnchor, constant:2.0).isActive = true
        self.productDescriptionLabel.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor, constant:40.0).isActive = true
        self.productDescriptionLabel.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor, constant:-40.0).isActive = true
        self.productDescriptionLabel.topAnchor.constraint(equalTo: self.productPriceLabel.bottomAnchor, constant:40.0).isActive = true
        self.attributeTableView.topAnchor.constraint(equalTo: self.productDescriptionLabel.bottomAnchor).isActive = true
        self.attributeTableView.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor).isActive = true
        self.attributeTableView.rightAnchor.constraint(equalTo: self.productConfigureContainerView.rightAnchor).isActive = true
        self.addToCartButton.leftAnchor.constraint(equalTo: self.productConfigureContainerView.leftAnchor).isActive = true
        self.addToCartButton.topAnchor.constraint(equalTo: self.attributeTableView.bottomAnchor).isActive = true
        self.addToCartButton.bottomAnchor.constraint(equalTo: self.productConfigureContainerView.bottomAnchor).isActive = true
        self.addToCartButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        self.cancelButton.leftAnchor.constraint(equalTo: self.addToCartButton.rightAnchor).isActive = true
        self.cancelButton.topAnchor.constraint(equalTo: self.addToCartButton.topAnchor).isActive = true
        self.cancelButton.bottomAnchor.constraint(equalTo: self.addToCartButton.bottomAnchor).isActive = true
        self.cancelButton.widthAnchor.constraint(equalTo: self.addToCartButton.widthAnchor, multiplier: 1.0).isActive = true
        
        
        self.view.layoutIfNeeded()
        
        self.productImageView.round()
        
        self.productNameLabel.text = self.product.name
        self.productPriceLabel.text = "Free" // TODO pull from pricebook
        self.productDescriptionLabel.text = "Description lorem ipsum dolor sit amet, consectur adispicing elit. Aliquam convallis tortor vel risus tincidunt, nec commodo." // TODO pull from product description
        
        
        categoryAttributes = CategoryAttributeStore.instance.attributes(forCategory: category)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.productConfigureContainerView.mask(offset: 50, direction: .convex, side: .top)
    }
    
    func closeButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true) {}
    }
    
    func addToCartButtonTouchUpInside(_ sender: Any) {
    }

}

extension ProductConfigureViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryAttributes.count
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ProductConfigureTableViewCell
//            cell.name = attribute.name
//            cell.imageURL = attribute.iconImageURL
//            cell.imageView?.image = UIImage()
            return cell
        }
        return UITableViewCell()
    }
}
