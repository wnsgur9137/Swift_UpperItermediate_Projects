//
//  MainViewController.swift
//  MVVM_study2
//
//  Created by 이준혁 on 2022/12/08.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var models = [Person]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PersonFollowingTableViewCell.self,
                           forCellReuseIdentifier: PersonFollowingTableViewCell.identifier)
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        setLayout()
    }


}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PersonFollowingTableViewCell.identifier,
            for: indexPath) as? PersonFollowingTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: PersonFollowingTableViewCellViewModel(with: model))
        cell.delegate = self
        return cell
    }
}

extension MainViewController: PersonFollowingTableViewCellDelegate {
    func personFollowingTableViewCellDelegate(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
        /*
         if viewModel.currentlyFollowing {
            여기서 내부를 구현
            ViewModel의 currentlyFollowing value의 값을 변경하는 방법도 있다.
            지금 구현한 것처럼 view에서 didTopWithButton() 내부에서 변경할 수도 있다.
         */
    }
}

extension MainViewController {
    
    private func configureModels() {
        ["Joe", "Dan", "Jeff", "Jenny", "Emily"].forEach{models.append(Person(name:$0))}
    }
    
    private func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
