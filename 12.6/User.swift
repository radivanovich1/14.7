//
//  User.swift
//  12.6
//
//  Created by user on 21.05.21.
//

import Foundation

class User{
    
    static let user = User()
    private let kUserName = "User.kUserName"
    private let kUserSurename = "User.kUserSurename"

    var Name: String{
        get{ return UserDefaults.standard.string(forKey: kUserName) ?? "empty"}
        set{ UserDefaults.standard.setValue(newValue, forKey: kUserName) }
    
    }
    var Surename: String{
        get{ return UserDefaults.standard.string(forKey: kUserSurename) ?? "empty"}
        set{ UserDefaults.standard.setValue(newValue, forKey: kUserSurename) }
    
    }
}
