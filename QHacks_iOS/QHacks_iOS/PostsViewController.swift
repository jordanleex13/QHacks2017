//
//  PostsViewController.swift
//  QHacks_iOS
//
//  Created by Jordan Lee on 2017-02-04.
//  Copyright © 2017 Jordan Lee. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var bottomLeft: UIButton!
    @IBOutlet weak var topRight: UIButton!
    @IBOutlet weak var bottomRight: UIButton!
    @IBOutlet weak var topLeft: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        //        topLeft.addTarget(self, action: #selector(PostsViewController.buttonClicked(_:)), for: .touchUpInside)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ActivityEventTableViewController") as! ActivityEventTableViewController
        
        
        if sender == topLeft {
            myVC.activity_type = "Running"
        } else if sender == topRight {
            myVC.activity_type = "Swimming"
        } else if sender == bottomLeft {
            myVC.activity_type = "Basketball"
        } else {
            myVC.activity_type = ""
        }
        
        navigationController?.pushViewController(myVC, animated: true)
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
