//
//  ViewController.swift
//  MVVM_study1
//
//  Created by 이준혁 on 2022/12/08.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var playerView: PlayerView? = nil
    var viewModel: PlayerViewModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.attribute()
        self.setLayout()
    }
}

extension MainViewController {
    
    func attribute() {
        let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 6000))
        let image = UIImage(systemName: "person")!
        let son = Player(name: "Son", birthday: birthday, position: .striker, image: image)
        
        self.playerView = PlayerView()
        
        let viewModel = PlayerViewModel(player: son)
        viewModel.configure(playerView!)
    }
    
    func setLayout() {
        self.view.addSubview(playerView!)
        playerView!.translatesAutoresizingMaskIntoConstraints = false
        playerView!.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
