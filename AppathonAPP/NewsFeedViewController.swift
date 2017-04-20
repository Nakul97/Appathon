//
//  NewsFeedViewController.swift
//  AppathonAPP
//
//  Created by Nakul on 05/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import NVActivityIndicatorView
import FirebaseStorage

class NewsFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
   @IBOutlet weak var NewsFeedTableView: UITableView!
    var count = 0
    var imageTemp:UIImageView!
    var DataTaken = [AnyObject]()

    @IBAction func TakePhoto(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imageTemp.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let storageRef = FIRStorage.storage().reference()
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/sample.jpg")
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        print("***************** done ************")
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.put(UIImageJPEGRepresentation(imageTemp.image!, 0.8)!, metadata: metaData) { metadata, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error)
                print("It")
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()
                print(downloadURL)
                print("done")
            }
        }
        dismiss(animated: true, completion: nil)


    }
    
    override func viewDidLoad() {
        let rootRef = FIRDatabase.database().reference()
        let view = NVActivityIndicatorView(frame: CGRect(x:self.view.frame.midX, y : self.view.frame.midY - 50 ,width:30,height:30), type: .ballPulse, color: UIColor.black, padding: 0)
        self.view.addSubview(view)
        view.startAnimating()
        FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                print(user.displayName)
                
                // User is signed in. Show home screen
            } else {
                print("none")
                // No User is signed in. Show user the login screen
            }
        }
        let conditionRef = rootRef.child("Feed")
        conditionRef.observe(.value) {
            (snap: FIRDataSnapshot) in
            self.DataTaken = snap.value as! [AnyObject]
            print(self.DataTaken[0]["Type"])
            self.count = self.DataTaken.count + 1
            self.NewsFeedTableView.reloadData()
            view.stopAnimating()
            
        }
        self.NewsFeedTableView.separatorStyle = .none
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var reuse:String = " "
        if(indexPath.row == 0)
        {
            reuse = "Hey"
        }
        else if(self.DataTaken[indexPath.row - 1]["Type"] as? String == "Post")
        {
            reuse = "Post"
        }
        else{
            reuse = "Level"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row == 0)
        {
            return 125
        }
        else if(indexPath.row == 1)
        {
            return 250
        }
        else{
            return 105
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return 125
        }
        else if(self.DataTaken[indexPath.row - 1]["Type"] as? String == "Post")
        {
            return 250
        }
        else{
            return 105
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
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
