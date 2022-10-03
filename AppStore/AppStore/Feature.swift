//
//  Feature.swift
//  AppStore
//
//  Created by 이준혁 on 2022/10/04.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
