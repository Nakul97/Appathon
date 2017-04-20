//
//  ViewController.swift
//  AppathonAPP
//
//  Created by Nakul on 04/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController, PassLoginInfo{
    
    @IBOutlet var contentView: UIView!
    var one: UIViewController!
    var two: UIViewController!
    var three: UIViewController!
    var four: UIViewController!
    

    @IBOutlet weak var TabBar: UIView!
    @IBOutlet var buttons:[UIButton]!
    
    var viewcontrollers = [UIViewController]()
    var selectedIndex:Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userName = UserDefaults.standard.string(forKey: "Username")
        let pass = UserDefaults.standard.string(forKey: "Password")
        print("***********")
        print(userName)
        DispatchQueue.main.async {
            if(userName == " " && pass == " ")
            {
                
                self.performSegue(withIdentifier: "Login", sender: self)
            }
            else
            {
                FIRAuth.auth()?.signIn(withEmail: userName!, password: pass!) { (user, error) in
                    print(user as Any)
                    print(error as Any)
                    if(error != nil)
                    {
                        self.performSegue(withIdentifier: "Login", sender: self)
                    }
                    
                    // ...
                }
                
            }
            
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        one = storyboard.instantiateViewController(withIdentifier: "Tab1")
        two = storyboard.instantiateViewController(withIdentifier: "Tab2")
        three = storyboard.instantiateViewController(withIdentifier: "Tab3")
        four = storyboard.instantiateViewController(withIdentifier: "Tab4")
        viewcontrollers = [one,two,three,four]
        buttons[selectedIndex].isSelected = true
        self.ChangeViewController(buttons[selectedIndex])
    }
    var count = 0
    @IBAction func HideTabBar(_ sender: UIButton) {
        if(sender.center.y < 300)
        {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
            sender.center.y -= self.view.frame.height
            self.TabBar.center.y += 50
        }, completion: nil)
        }
        else{
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                sender.center.y += self.view.frame.height
                self.TabBar.center.y -= 50
            }, completion: nil)
        }
        print("button tapped")
        count+=1
        self.contentView.bringSubview(toFront: sender)
        self.view.clipsToBounds = true
        sender.clipsToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ChangeViewController(_ sender: UIButton) {
        TabBar.isHidden = false
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewcontrollers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        sender.isSelected = true
        let vc = viewcontrollers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = self.contentView.bounds
        self.contentView.addSubview(vc.view)
        self.contentView.bringSubview(toFront: TabBar)
        let remove = storyboard?.instantiateViewController(withIdentifier: "Tab2")
        if(vc == remove)
        {
            TabBar.isHidden = true
        }
        
        
        
    }
    func LoginInfo(Username: String, Password: String)
    {
        UserDefaults.standard.set(Username, forKey:"Username")
        UserDefaults.standard.set(Password, forKey:"Password")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Login")
        {
            let LoginWindow = segue.destination as! LoginViewController
            LoginWindow.passLoginInfo = self
        }
    }
    
}

