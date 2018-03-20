//
//  ViewController.swift
//  Provider
//
//  Created by Nicholas McDonald on 3/6/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit
import Common

class ViewController: UIViewController {
    
    fileprivate var tableView = UITableView(frame: .zero, style: .plain)
    fileprivate var orders:[LocalOrder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let safe = self.view.safeAreaLayoutGuide
        
        self.orders = LocalOrderStore.instance.currentOrders()
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorColor = UIColor(white: 0.0, alpha: 0.3)
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "itemCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 120.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(self.tableView)
        
        let completeButton = UIButton(type: .custom)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.setTitle("COMPLETE TOP ORDER", for: .normal)
        completeButton.titleLabel?.textColor = UIColor.white
        completeButton.titleLabel?.font = Theme.appBoldFont(15.0)
        completeButton.backgroundColor = Theme.appAccentColor01
        completeButton.addTarget(self, action: #selector(didPressCompleteTopOrder), for: .touchUpInside)
        self.view.addSubview(completeButton)
        
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: safe.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: completeButton.topAnchor).isActive = true
        
        completeButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        completeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        completeButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        completeButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func didPressCompleteTopOrder() {
    
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100.0
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! OrderTableViewCell
        let order = self.orders[indexPath.row]
        for item in order.orderItems {
            cell.add(product: item.product, options: item.options)
        }
        return cell
    }
}

