//
//  ViewController.swift
//  QHacks_iOS
//
//  Created by Jordan Lee on 2017-02-03.
//  Copyright © 2017 Jordan Lee. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController {
    
    
    
    // MARK: Properties
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var isGrantedNotificationAccess:Bool = false
    
    @IBAction func send10SecNotification(_ sender: UIButton) {
        if isGrantedNotificationAccess{
            //add notification code here
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("This is a message in the console.")
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedNotificationAccess = granted
            }
        )
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SegueToMain(_ sender: AnyObject) {
        
        Global.sharedInstance.setName(name: usernameField.text!)
        //performSegue(withIdentifier: "TabBarViewController", sender: self)
        
//        let myVC = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
//        
//        navigationController?.pushViewController(myVC, animated: true)
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
        self.present(controller!, animated: true, completion: nil)
        

    }
    // Twilio server
    func printMessagesForUser() -> Void {
        let json = ["user": Global.sharedInstance.user_id, "phone_number": "6048121916"]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let url = NSURL(string: "http://127.0.0.1:5000/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if error != nil{
                    print("Error -> \(error)")
                    return
                }
                do {
                    let result = try JSONSerialization.data(withJSONObject: data!)
//                        , options: .AllowFragments) as? [String:AnyObject]
                    print("Result -> \(result)")
                    
                } catch {
                    print("Error -> \(error)")
                }
            }
            
            task.resume()
        } catch {
            print(error)
        }
    }


}

