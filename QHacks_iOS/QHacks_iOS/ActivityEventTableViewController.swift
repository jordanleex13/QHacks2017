//
//  ActivityEventTableViewController.swift
//  QHacks_iOS
//
//  Created by Jordan Lee on 2017-02-04.
//  Copyright © 2017 Jordan Lee. All rights reserved.
//

import UIKit
import Firebase

// Class to populate events in a table view from Firebase
class ActivityEventTableViewController: UITableViewController {

    @IBOutlet weak var activity_title: UILabel!
    
    var items: [Event] = []
    var rootRef: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  Create a reference to your database
        
        //ref = FIRDatabase.database().reference(withPath: "events")
        
        rootRef = FIRDatabase.database().reference()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        

        print("LET's GO!")
        let childRef = rootRef.child("events")

//        childRef.observe(.value, with: { snapshot in
//            print(snapshot.value)
//        })
        // 1
        childRef.observe(.value, with: { snapshot in
            // 2
            var newItems: [Event] = []
            
            // 3
//            let snapshotValue = snapshot.value
//            print(snapshotValue)
            for item in snapshot.children {
                // 4
                print(item)
                let event = Event(snapshot: item as! FIRDataSnapshot)
                newItems.append(event)
            }
            
            // 5
            self.items = newItems
            self.tableView.reloadData()
        })
        
        writeToDB()
    }
    
    func writeToDB() {
        
        Global.sharedInstance.setName(name: "Jordan")
        print(Global.sharedInstance.user_id)
        
        // MUST SET this as going to this activity
        let choices = ["Swimming", "Running", "Basketball", "Biking"]
        let randomIndex = Int(arc4random_uniform(UInt32(choices.count)))
        Global.sharedInstance.setActivity(activity: choices[randomIndex])
        
        print(Global.sharedInstance.activity!)
        let gInstance = Global.sharedInstance
        let event = Event(activity_type: gInstance.activity!, creator_id: gInstance.user_id!)
  
        let eventRef = rootRef.child("events")
        eventRef.childByAutoId().setValue(event.toAnyObject())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...

        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let event = items[indexPath.row]
        
        cell.textLabel?.text = event.activity_type
        cell.detailTextLabel?.text = event.creator_id
        
        //toggleCellCheckbox(cell, isCompleted: groceryItem.completed)
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        var event = items[indexPath.row]
//        let toggledCompletion = !groceryItem.completed
//        
//        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
//        groceryItem.completed = toggledCompletion
        //tableView.reloadData()
        
        print(event.toAnyObject())
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
