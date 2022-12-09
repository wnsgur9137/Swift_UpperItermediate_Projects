//
//  ViewModel.swift
//  MVVM_study2
//
//  Created by 이준혁 on 2022/12/08.
//

import UIKit

struct PersonFollowingTableViewCellViewModel {
    let name: String
    let username: String
    var currentlyFollowing: Bool
    let image: UIImage?
    
    init(with model: Person) {
        self.name = model.name
        self.username = model.username
        self.currentlyFollowing = false
        self.image = UIImage(systemName: "person")
    }
}
