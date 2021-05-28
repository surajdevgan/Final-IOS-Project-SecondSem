//
//  RegisterViewController.swift
//  FinalProjectSecondSem
//
//  Created by Sukhjeet Singh on 23/05/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        
        
        
       
        
        
        
        if let name = txtName.text, let email = txtEmail.text, let passwrd = txtPassword.text
        {
            
            
            if name.isEmpty || email.isEmpty || passwrd.isEmpty{
                
                // create the alert
                let alert = UIAlertController(title: "Registration Fail!", message: "All Fields are mandatory", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
            else {
                
                
                let newUser = User(context: DBManager.share.context)
                newUser.name = name
                newUser.email = email
                newUser.password = passwrd
                newUser.game_score = 0
                
                
                DBManager.share.saveContext()
                
                
                let loginViewController: UIViewController = (
                    self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
                    
                    self.navigationController?.pushViewController(loginViewController, animated: true)
                
                }
                
            }
          
            
           
    }
    
    
    
    @IBAction func btnSignIn(_ sender: Any) {
    }
    
    

}
