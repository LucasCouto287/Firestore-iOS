//
//  HomeViewController.swift
//  Firestore-iOS
//
//  Created by Abdullah Khan on 2019-09-14.
//  Copyright © 2019 Abdullah Khan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add user's first name to the title
        getUserName { (name) in
            self.titleLabel.text! = "Welcome, \(name)!"
        }

    }
    
    // get the signed-in user's first name using their uid from Cloud Firestore
    func getUserName(completion: @escaping (String) -> Void){
        let db = Firestore.firestore()
        let userUID = UserDefaults.standard.object(forKey: "uid")
        
        let userInfo = db.collection("users").document(userUID as? String ?? Auth.auth().currentUser!.uid)

        userInfo.getDocument{ (document, error) in
            if let document = document, document.exists {
                let data = document.data() ?? nil
                completion(data?["firstName"] as! String)
            }
            else {
                print(error?.localizedDescription ?? "nil")
            }
        }

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            if Auth.auth().currentUser == nil {
                // remove user session from device
                UserDefaults.standard.removeObject(forKey: "uid")
                UserDefaults.standard.synchronize()
                
                self.transitionToMain()
            }
        } catch _ as NSError {
            // handle logout error by showing an alert
            let alert = UIAlertController(title: "Logout Error", message: "There was an error logging you out. Try restarting the app, please.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func transitionToMain() {
        let initialViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.initialViewController) as? ViewController
        
        view.window?.rootViewController = initialViewController
        view.window?.makeKeyAndVisible()
    }
    
    

}
