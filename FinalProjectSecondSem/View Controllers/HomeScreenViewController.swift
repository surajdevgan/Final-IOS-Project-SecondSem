//
//  HomeScreenViewController.swift
//  FinalProjectSecondSem
//
//  Created by Sukhjeet Singh on 23/05/21.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var scoreboardtableview: UITableView!
    @IBOutlet weak var txtwelcome: UILabel!
    @IBOutlet weak var txtscore: UILabel!
   // var login:Bool = false
  //  let userDefaults = UserDefaults()
    
    var users = [User] ()
    var userdefaults = UserDefaults()
    
    var username = ""
    var userscore = ""

    var useremail = ""
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users.count>3
        {
            return 3
            
        }
        
        else{
            
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scoreboardtableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let aUser = users[indexPath.row]
        cell.textLabel?.text = aUser.name
        cell.detailTextLabel?.text = String(aUser.game_score)
        return cell
        

    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        users = DBManager.share.fetchUser()
        scoreboardtableview.reloadData()
        
       /*
        if ( login == true ){
            
            login = false
         
            let homeViewController: UIViewController = (
                self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
                
                self.navigationController?.pushViewController(homeViewController, animated: true)
        }
        
         
 
 */
       username = userdefaults.value(forKey: "name") as! String
        useremail =  userdefaults.value(forKey: "email") as! String
        txtwelcome.text = "Welcome "+String(username)
        users = DBManager.share.fetchUser()
        
        for auser in users {
            

            if auser.email == useremail
            {
                
                
                txtscore.text = "Your Highest Score is: "+String(auser.game_score)
                
            }
            
            
        }
        
      
    }
    
    //logout button on home screen
    
    @IBAction func logout_button(_ sender: Any) {
        
        
        
        
          // login == false
     
            UserDefaults.resetStandardUserDefaults()
      
   
            userdefaults.removeObject(forKey: "login")
       
        let homeViewController: UIViewController = (
            self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
            
            self.navigationController?.pushViewController(homeViewController, animated: true)
    
        
    }
    }

