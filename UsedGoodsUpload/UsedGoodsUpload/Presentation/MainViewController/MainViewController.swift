//
//  MainViewController.swift
//  UsedGoodsUpload
//
//  Created by 이준혁 on 2022/11/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        // index 0 : TitleTextFieldCell
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: "TitleTextFieldCell")
        
        return tableView
    }()
    
    private lazy var submitButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "제출"
        button.style = .done
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewmodel: MainViewModel) {
        
    }
    
}

private extension MainViewController {
    func attribute() {
        self.title = "중고거래 글쓰기"
        view.backgroundColor = .white
        
        navigationItem.setRightBarButton(submitButton, animated: true)
    }
    
    func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title: String, message: String?)
extension Reactive where Base: MainViewController {
    var setAlert: Binder<Alert> {
        // base -> MainViewController
        return Binder(base) { base, data in
            let alertController = UIAlertController(
                title: data.title,
                message: data.message,
                preferredStyle: .alert
            )
            let alertAction = UIAlertAction(
                title: "확인",
                style: .cancel,
                handler: nil
            )
            alertController.addAction(alertAction)
            base.present(alertController, animated: true, completion: nil)
        }
    }
}
