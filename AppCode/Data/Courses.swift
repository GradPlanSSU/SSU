//
//  Courses.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/2/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class Courses: NSObject, Codable {

    
    override init() {
        courses = [Course]()
        super.init()
    }
    var courses: [Course]
    
}
