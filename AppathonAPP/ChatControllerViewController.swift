//
//  ChatControllerViewController.swift
//  AppathonAPP
//
//  Created by Nakul on 05/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit

class ChatControllerViewController: UIViewController {

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.view.viewWithTag(15)?.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.viewWithTag(15)?.isHidden = false
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
