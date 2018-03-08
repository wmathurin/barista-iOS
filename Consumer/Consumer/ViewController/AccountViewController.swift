//
//  AccountViewController.swift
//  Consumer
//
//  Created by David Vieser on 2/5/18.
//  Copyright © 2018 Salesforce. All rights reserved.
//

import UIKit
import SmartStore
import SalesforceSDKCore
import Common

class AccountViewController: UIViewController {

    @IBAction func smartStoreDebugButtonPressed(_ sender: Any) {
        let smartStoreViewController = SFSmartStoreInspectorViewController.init(store:  SFSmartStore.sharedStore(withName: kDefaultSmartStoreName) as! SFSmartStore)
        present(smartStoreViewController, animated: true, completion: nil)
    }
    
    fileprivate var quote:Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logoutButton = UIButton(type: .custom)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(UIColor.red, for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        self.view.addSubview(logoutButton)
        
        logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant:60.0).isActive = true
    }
    
    @objc func logout() {
        SFUserAccountManager.sharedInstance().logout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
