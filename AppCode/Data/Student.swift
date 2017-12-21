//
//  Student.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/2/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import UIKit

class Student: NSObject, Codable{
    override init(){
        fname = ""
        lname = ""
        mname = ""
        student_id = ""
        token = ""
        super.init()
    }
    var fname: String
    var lname: String
    var mname: String?
    var student_id: String
    var token: String
}
