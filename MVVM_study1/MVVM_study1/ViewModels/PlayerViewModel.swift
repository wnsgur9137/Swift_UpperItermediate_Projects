//
//  PlayerViewModel.swift
//  MVVM_study1
//
//  Created by 이준혁 on 2022/12/08.
//

import UIKit

final class PlayerViewModel {
    private let player: Player
    private let calendar: Calendar
    
    init(player: Player) {
        self.player = player
        self.calendar = Calendar(identifier: .gregorian)
    }
    
    var name: String {
        return "선수 이름: \(player.name)"
    }
    
    var image: UIImage {
        return player.image
    }
    
    var ageText: String {
        let today = calendar.startOfDay(for: Date())
        let birthday = calendar.startOfDay(for: player.birthday)
        let components = calendar.dateComponents([.year], from: birthday, to: today)
        let age = components.year!
        return "나이: \(age)세"
    }
    
    var transferFeeText: String {
        var string = "주급: "
        switch player.position {
        case .striker:
            string += "5억"
        case .midfielder:
            string += "3억"
        case .defenser:
            string += "2억"
        case .goalkeeper:
            string += "1억"
        }
        return string
    }
}

extension PlayerViewModel {
    func configure(_ view: PlayerView) {
        view.imageView.image = self.image
        view.nameLabel.text = self.name
        view.ageLabel.text = self.ageText
        view.transferFeeLabel.text = self.transferFeeText
    }
}
