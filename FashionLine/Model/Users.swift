//
//  Users.swift
//  FashionLine
//
//  Created by Furkan Y. on 24.12.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import Foundation

class Users{
    // MARK: - Properties
    static let sharedInstance = Users()
    var linkLabel: String?
    var nameArray = [String]()
    var nameCombineArray = [String]()
    var linkArray = [String]()
    var timeArray = [String]()
    var stylerCommentArray = [String]()
    var heightArray = [String]()
    var genderArray = [String]()
    var ePostaArray = [String]()
    var weightArray = [String]()
    var styleArray = [String]()
    var ageArray = [String]()
    var passwordArray = [String]()
}
class Admin {
    static let sharedInstance = Admin()
    var userName:String?
    var height: String?
    var weight: String?
    var sex: String?
    var email: String?
    var style: String?
    var age: String?
    var toWhere: String?
    var time: String?
    var styleRequest: String?
    var note: String?
}
