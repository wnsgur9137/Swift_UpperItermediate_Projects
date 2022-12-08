//
//  CategoryListViewController.swift
//  UsedGoodsUpload
//
//  Created by 이준혁 on 2022/11/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CategoryListViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CategoryViewModel) {
//        viewModel.cellData
//            .drive(tableView.rx.items) { tv, row, data in
//                
//            }
    }
}

private extension CategoryListViewController {
    func attribute() {
        
    }
    
    func layout() {
        
    }
}
