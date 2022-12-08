//
//  ViewController.swift
//  MVVM_study1
//
//  Created by 이준혁 on 2022/12/08.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 6000))
        let image = UIImage(systemName: "person")!
        let son = Player(name: "Son", birthday: birthday, position: .striker, image: image)
        
        let playerView = PlayerView()
        
        let viewModel = PlayerViewModel(player: son)
        viewModel.configure(playerView)
        
        self.view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }


}

