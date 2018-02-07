//
//  ProductViewController.swift
//  Consumer
//
//  Created by David Vieser on 1/31/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    var productSelectedSegueName = "ProductSelectedSegue"
    
    @IBOutlet weak var productTableView: UITableView!
    
    var products: [Product?] = [] {
        didSet {
            
        }
    }
    
    var category: Category? = nil {
        didSet {
            DispatchQueue.main.async(execute: {
                self.products = ProductStore.instance.records(forCategory: self.category)
            })
        }
    }
    
    override func loadView()
    {
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = category?.name
        productTableView.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination: ProductConfigureViewController = segue.destination as? ProductConfigureViewController,
            let product: Product = sender as? Product {
            destination.product = product
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ProductCell"
        
        // Dequeue or create a cell of the appropriate type.
        let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductTableViewCell
        
        // Configure the cell to show the data.
        if let product: Product = products[indexPath.row] {
            cell.productName = product.name
            cell.productImageURL = product.featuredImageRightURL
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: productSelectedSegueName, sender: products[indexPath.row])
    }
}
