//
//  EnrollmentRequirements.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/6/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class EnrollmentRequirements: NSObject, Codable{

    override init() {
        course = ""
        course_title = ""
        department = ""
        units = 0
        prerequisites = [String]()
        corequisites = [String]()
        super.init()
    }
    var course: String
    var course_title: String
    var department: String
    var units: Int
    var prerequisites: [String?]
    var corequisites: [String?]
}
