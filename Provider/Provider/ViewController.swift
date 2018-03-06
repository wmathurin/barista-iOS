//
//  ViewController.swift
//  Provider
//
//  Created by Nicholas McDonald on 3/6/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 100.0
//    }
//}

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.cartItems.count
//    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! CartItemTableViewCell
//        guard let item = self.cartItems[indexPath.row], let productId = item.product.productId else {return cell}
//        let product = ProductStore.instance.product(from: productId)
//        cell.itemName = product?.name
//
//        // todo add business logic to handle size cost changes to main item
//        // add option prices
//        for option in item.options {
//            guard let name = option.product.productDescription, let type = option.product.optionType else { continue }
//            if type == .integer {
//                cell.addOption("(\(option.quantity)) \(name)")
//            } else {
//                cell.addOption(name)
//            }
//        }
//        cell.price = "FREE"
//        return cell
//    }
//}

