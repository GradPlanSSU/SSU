//
//  ExampleData.swift
//  SSUSchedulePlanner
//
//  Created by Ivan Lim on 11/14/17.
//  Copyright © 2017 Ivan Lim. All rights reserved.
//

import Foundation

//
// MARK: - Section Data Structure
//
public struct Item {
    var name: String
    var detail: String
    
    public init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed

    }
}

public var sectionsData: [Section] = [
    Section(name: "CS Core Classes", items: [
        Item(name: "CS 115", detail: "Taken"),
        Item(name: "CS 210", detail: "Taken"),
        Item(name: "CS 215", detail: "Taken"),
        Item(name: "CS 242", detail: "Not Taken"),
        Item(name: "CS 252", detail: "Not Taken"),
        Item(name: "CS 315", detail: "Not Taken"),
        Item(name: "CS 355", detail: "Not Taken"),
        Item(name: "CS 370", detail: "Not Taken"),
        Item(name: "CS 450", detail: "Not Taken"),
        Item(name: "CS 454", detail: "Not Taken"),
        Item(name: "CS 460", detail: "Not Taken"),
        Item(name: "CS 470", detail: "Not Taken"),
        ]),
    Section(name: "General Education", items: [
        Item(name: "A1: Written and Oral Analysis", detail: ""),
        Item(name: "A2: Fundamentals of Comm", detail: ""),
        Item(name: "A3: Critical Thinking", detail: ""),
        Item(name: "B1: Physical Sciences", detail: ""),
        Item(name: "B2: Biological Sciences", detail: ""),
        Item(name: "B3: Specific Emphasis", detail: ""),
        Item(name: "B4: Mathematical Concepts", detail: ""),
        Item(name: "C1: Arts, Thtr, Dnc, Mus, Flm", detail: ""),
        Item(name: "C2: Lit, Philosophies, Values", detail: ""),
        Item(name: "C3: Comp Persp/Foreign Lang", detail: ""),
        Item(name: "D1: Individual and Society", detail: ""),
        Item(name: "D2: World History & Civ", detail: ""),
        Item(name: "D3: United States History", detail: ""),
        Item(name: "D4: U.S. Const & CA Gov't", detail: ""),
        Item(name: "D5: Contemp Interntl Persp", detail: ""),
        Item(name: "E: Integrated Person", detail: ""),
        Item(name: "GE: Ethnic Studies Course", detail: ""),
        Item(name: "GE: Lab Course", detail: "")
        ]),
    Section(name: "Other", items: [
        Item(name: "WEPT", detail: "Usually Taken During Junior Year"),
        ])
]

/*
public var termData: [Section] = [
    Section(name: "Fall 2017", items: [
        Item(name: "CS 115", detail: ""),
        Item(name: "CALC 161", detail: ""),
        Item(name: "PHIL 120", detail: ""),
        Item(name: "SPAN 101", detail: ""),
        ]),
    Section(name: "Spring 2018", items: [
        Item(name: "CS 215", detail: ""),
        Item(name: "CS 210", detail: ""),
        Item(name: "CS 242", detail: ""),
        Item(name: "CALC 211", detail: ""),
        ])
]
*/


