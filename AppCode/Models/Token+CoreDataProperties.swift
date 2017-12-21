//
//  Token+CoreDataProperties.swift
//  SSUSchedulePlanner
//
//  Created by student on 12/10/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//
//

import Foundation
import CoreData


extension Token {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Token> {
        return NSFetchRequest<Token>(entityName: "Token")
    }

    @NSManaged public var token: String?

}
