//
//  Model.swift
//  MVVM_study2
//
//  Created by 이준혁 on 2022/12/08.
//

import Foundation

enum Gender {
    case male, female, unspecified
}

struct Person {
    let name: String
    let birthdate: Date?
    let middleName: String?
    let address: String?
    let gender: Gender
    var username = "LeeJunHyeok"
    
    init(name: String, birthdate: Date? = nil, middleName: String? = nil, address: String? = nil, gender: Gender = .unspecified) {
        self.name = name
        self.birthdate = birthdate
        self.middleName = middleName
        self.address = address
        self.gender = gender
    }
}
