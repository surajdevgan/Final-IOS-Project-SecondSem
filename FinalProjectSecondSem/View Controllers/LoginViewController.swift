//
//  ViewController.swift
//  FinalProjectSecondSem
//
//  Created by Suraaj Devgn on 23/05/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtemail: UITextField!
    
    @IBOutlet weak var txtpassword: UITextField!
    var users = [User]()
    var login:Bool = false
    let userDefaults = UserDefaults()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        users = DBManager.share.fetchUser()
       if (userDefaults.value(forKey: "login") != nil) == true
        {
            let homeViewController: UIViewController = (
                self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController)!
                
                self.navigationController?.pushViewController(homeViewController, animated: true)
            
            
        }
       
        
       

        
    }
    
    
    @IBAction func btnLoginClick(_ sender: Any) {
        
        
        if txtemail.text!.isEmpty || txtpassword.text!.isEmpty{
            
            
            
            // create the alert
            let alert = UIAlertController(title: "Login Fail!", message: "All Fields are mandatory", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        
        // here we are looping through each and every user present inside database
        for user in users{
         
                    
                    if txtemail.text == user.email && txtpassword.text == user.password
                    {
                        login = true
                        
                        userDefaults.setValue(user.name, forKey: "name")
                        userDefaults.setValue(user.email, forKey: "email")
                        userDefaults.setValue(true, forKey: "login")
                        let homeViewController: UIViewController = (
                            self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as? HomeScreenViewController)!
                            
                            self.navigationController?.pushViewController(homeViewController, animated: true)
                        
                    
                            
                    }
            
        }
        
        
        if login == false {
            
            
        
            // create the alert
            let alert = UIAlertController(title: "Login Fail!", message: "No User Found", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
       
        
        
    
        
        
    }
    

}

