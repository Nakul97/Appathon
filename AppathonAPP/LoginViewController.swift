//
//  LoginViewController.swift
//  AppathonAPP
//
//  Created by Nakul on 04/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase

protocol PassLoginInfo{
    func LoginInfo(Username: String, Password: String)
}

class LoginViewController: UIViewController {
    
    var passLoginInfo: PassLoginInfo!
    
    @IBOutlet weak var PasswordLabel: UITextField!
    @IBOutlet weak var UsernameLabel: UITextField!
    var email:String!
    var password:String!
    @IBAction func SignUP(_ sender: Any) {
        self.email = UsernameLabel.text
        self.password = PasswordLabel.text
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            print(user as Any)
            print(error as Any )
        }
        
    }

    @IBAction func Login(_ sender: UIButton) {
        self.email = UsernameLabel.text
        self.password = PasswordLabel.text
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            print(user as Any)
            print(error as Any)
            if(error == nil)
            {
                self.passLoginInfo.LoginInfo(Username: self.UsernameLabel.text!, Password: self.PasswordLabel.text!)
                self.dismiss(animated: true, completion: nil)
            }
            
            // ...
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
