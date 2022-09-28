//
//  AssetMenu.swift
//  SwiftUIStudy_MyAssets
//
//  Created by 이준혁 on 2022/09/28.
//

import Foundation

enum AssetMenu: String, Identifiable, Decodable {
    case creditScore    // 신용 점수
    case bankAccount    // 계좌
    case investment     // 투자
    case loan           // 대출
    case insurance      // 보험
    case creditCard     // 카드
    case cash           // 현금영수증
    case realEstate     // 부동산
    
    // Identifiable는 반드시 id를 생성해야한다.
    var id: String {
        return self.rawValue
    }
    
    var systemImageName: String {
        switch self {
        case .creditScore:
            return "number.circle"
        case .bankAccount:
            return "banknote"
        case .investment:
            return "bitcoinsign.circle"
        case .loan:
            return "hand.wave"
        case .insurance:
            return "lock.shield"
        case .creditCard:
            return "creditcard"
        case .cash:
            return "dollarsign.circle"
        case .realEstate:
            return "house.fill"
        }
    }
    
    var title: String {
        switch self {
        case .creditScore:
            return "신용점수"
        case .bankAccount:
            return "계좌"
        case .investment:
            return "투자"
        case .loan:
            return "대출"
        case .insurance:
            return "보험"
        case .creditCard:
            return "카드"
        case .cash:
            return "현금영수증"
        case .realEstate:
            return "부동산"
        }
    }
}
