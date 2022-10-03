//
//  RankingFeature.swift
//  AppStore
//
//  Created by 이준혁 on 2022/10/04.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
