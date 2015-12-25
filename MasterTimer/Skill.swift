//
//  Skill.swift
//  MasterTimer
//
//  Created by Matthew Krager on 9/7/15.
//  Copyright (c) 2015 Matthew Krager. All rights reserved.
//

import UIKit

class Skill: NSObject {
    enum SkillLevel:String {
        case KnowNothing = "Know-Nothing"
        case Beginner = "Beginner"
        case Novice = "Novice"
        case Mediocre = "Mediocre"
        case Experienced = "Experienced"
        case Expert = "Expert"
        case Master = "Master"
        case AllKnowing = "All-Knowing"
    }
    var name: NSString! = ""
    var timeSpent: NSTimeInterval = NSTimeInterval()
    var level:SkillLevel = SkillLevel.KnowNothing
    
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


