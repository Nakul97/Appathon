//
//  ImageSelectionViewController.swift
//  AppathonAPP
//
//  Created by Nakul on 05/03/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageSelectionViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = #imageLiteral(resourceName: "cameraPost")
        let storageRef = FIRStorage.storage().reference()
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("images/sample.jpg")
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        
        // Upload the file to the path "images/rivers.jpg"
        print("***************** done ************")
        let uploadTask = riversRef.put(UIImageJPEGRepresentation(image, 0.8)!, metadata: metaData) { metadata, error in
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
