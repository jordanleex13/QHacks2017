//
//  Global.swift
//  QHacks_iOS
//
//  Created by Jordan Lee on 2017-02-04.
//  Copyright © 2017 Jordan Lee. All rights reserved.
//

import Foundation

class Global {
    static let sharedInstance = Global()
    
    var user_id : String?
    var activity : String?

    
    func setActivity(activity: String) {
        self.activity = activity
    }
    
    func setName(name: String) {
        self.user_id = name;
    }
}

