//
//  CreateEventViewController.swift
//  QHacks_iOS
//
//  Created by Jordan Lee on 2017-02-05.
//  Copyright © 2017 Jordan Lee. All rights reserved.
//

import UIKit
import Firebase

class CreateEventViewController: UIViewController {

    
    @IBOutlet weak var bikeButton: UIButton!
    @IBOutlet weak var gymButton: UIButton!
    @IBOutlet weak var createEventButton: UIButton!
    @IBOutlet weak var runButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var otherTextField: UITextField!
    
    var radioButtonController : SSRadioButtonsController?
    var rootRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Create event")
        print(Global.sharedInstance.user_id)
        
        rootRef = FIRDatabase.database().reference()
        radioButtonController = SSRadioButtonsController(buttons: bikeButton, gymButton, runButton, otherButton)
        
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
    
    @IBAction func saveToDB(_ sender: AnyObject) {
        
        let userid = Global.sharedInstance.user_id
        
        let selected = radioButtonController?.selectedButton()
        
        let activity_type : String!
        if selected == bikeButton {
            activity_type = "bike"
        }
        else if selected == runButton {
            activity_type = "run"
        }
            
        else if selected == gymButton {
            activity_type = "gym"
        }
        else if selected == otherButton {
            activity_type = otherTextField.text!
        } else {
            return;
        }
        
        
        let event = Event(activity_type: activity_type, creator_id: userid!)
        
        // Save to database
        let eventRef = rootRef.child("events")
        eventRef.childByAutoId().setValue(event.toAnyObject())
        
        print("Saved to DB")
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
