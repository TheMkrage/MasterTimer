//
//  Skill.swift
//  MasterTimer
//
//  Created by Matthew Krager on 9/7/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

import UIKit

class Skill: NSObject {
    var name: NSString! = ""
    var timeSpent: NSTimeInterval = NSTimeInterval()
    
    init(skillName:NSString) {
        self.name = skillName
    }
    
    init(skillName:NSString, timeTwo:NSTimeInterval) {
        self.name = skillName
        self.timeSpent = timeTwo
    }
    
    init(skillName:NSString, timeInDouble:Double) {
        self.name = skillName
        self.timeSpent = timeInDouble
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


