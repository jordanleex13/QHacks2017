//
//  Activity.swift
//  QHacks_iOS
//
//  Created by Jordan Lee on 2017-02-04.
//  Copyright © 2017 Jordan Lee. All rights reserved.
//

import Foundation
import Firebase

class Event {
    
    var activity_type : String
    var time          : String
    var creator_id    : String
    var participants  : [String]
    
    let ref: FIRDatabaseReference?
    var key           : String

    
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        activity_type = snapshotValue["activity_type"] as! String
        time = snapshotValue["time"] as! String
        creator_id = snapshotValue["creator_id"] as! String
        participants = snapshotValue["participants"] as! [String]
        
        ref = snapshot.ref
    }

    
    init(activity_type: String, creator_id: String) {
        self.activity_type = activity_type
        self.creator_id = creator_id
        self.time = NSDate().description
        self.participants = [String]()
        self.participants.append("")
        
        self.key = ""
        self.ref = nil
    }
    
    func addParticipant(participant: String) {
        participants.append(participant)
    }
    
    
    func toAnyObject() -> Any {
        return [
            "activity_type": activity_type.description,
            "time": time.description,
            "creator_id": creator_id.description,
            "participants": participants
        ]
    }
//    required init(snapshot: FIRDataSnapshot) {
//        fatalError("init(snapshot:) has not been implemented")
//    }
    
//    func getTime() {
//        let date = NSDate()
////        let calendar = NSCalendar.current
////        let hour = calendar.component(.hour, from: date as Date)
////        let minutes = calendar.component(.minute, from: date as Date)
////        
////        print(date)
////        print(hour)
////        print(minutes)
//        return date
//        
//    }
}
