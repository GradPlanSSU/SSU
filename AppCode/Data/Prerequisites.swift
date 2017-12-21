//
//  Prerequisites.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/6/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class Prerequisites: NSObject, Codable{

    override init() {
        courses = [EnrollmentRequirements]()
        super.init()
    }
    var courses: [EnrollmentRequirements]
}
