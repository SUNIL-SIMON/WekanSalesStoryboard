//
//  LoginViewController.swift
//  Sales
//
//  Created by Sunil Simon on 17/10/23.
//

import Foundation
import UIKit
class LoginViewController: UIViewController{
    
    let loginViewModel = LoginViewModel()
    @IBOutlet var userLabel : UITextField!
    @IBOutlet var pwdLabel : UITextField!
    @IBOutlet var loginButton : UIButton!
    @IBOutlet var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUploginStateObserver()
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loginViewModel.chkLoginStatus()
    }
    
    func setUploginStateObserver()
    {
        self.loginViewModel.loginStateChangedBindingNotifier = { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            if self?.loginViewModel.loginState == .WAITING{
                self?.activityIndicator.isHidden = false
                self?.activityIndicator.startAnimating()
            }
            else if self?.loginViewModel.loginState == .LOGGEDIN{
                self?.presentSalesPage()
            }
            else if self?.loginViewModel.loginState == .NOTLOGGEDIN{
                //SHOW FAILURE ALERT
            }
        }
    }
    
    @IBAction func login(){
        guard userLabel.text != nil && pwdLabel.text != nil else{ return }
        loginViewModel.login(user: userLabel.text!, pwd: pwdLabel.text!)
    }
    
    func presentSalesPage()
    {
        let salesViewController = self.storyboard?.instantiateViewController(withIdentifier: "SalesViewController") as! SalesViewController
        salesViewController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(salesViewController, animated: true)
    }
}
