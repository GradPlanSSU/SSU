//
//  Course.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/2/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class Course: NSObject, Codable {
    override init(){
        id = 0
        catalog = ""
        subject = ""
        course_title = ""
        ge_designation = ""
        units = ""
        min_units = ""
        max_units = ""
        super.init()
    }
    var id: Int
    var catalog: String
    var subject: String
    var course_title: String
    var ge_designation: String?
    var units: String
    var min_units: String
    var max_units: String
}
