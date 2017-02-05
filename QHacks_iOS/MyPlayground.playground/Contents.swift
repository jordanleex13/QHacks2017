//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print(str)

let date = NSDate()
let calendar = NSCalendar.current
let hour = calendar.component(.hour, from: date as Date)
let minutes = calendar.component(.minute, from: date as Date)

print(date.description)
print(hour)
print(minutes)

