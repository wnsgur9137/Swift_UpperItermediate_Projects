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
        
        //index row 1 : Category
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategorySelectCell")
        
        //index row 2 : PriceTextFieldCell
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: "PriceTextFieldCell")
        
        //index row 3 : DetailWriteFormCell
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: "DetailWriteFormCell")
        
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
    
    func bind(_ viewModel: MainViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tv, row, data in
                switch row {
                case 0:
                    let cell = tv.dequeueReusableCell(withIdentifier: "TitleTextFieldCell", for: IndexPath(row: row, section: 0)) as! TitleTextFieldCell
                    cell.selectionStyle = .none
                    cell.titleInputField.placeholder = data
                    cell.bind(viewModel.titleTextFieldCellViewModel)
                    return cell
                case 1:
                    let cell = tv.dequeueReusableCell(withIdentifier: "CategorySelectCell", for: IndexPath(row: row, section: 0))
                    cell.selectionStyle = .none
                    cell.textLabel?.text = data
                    cell.accessoryType = .disclosureIndicator
                    return cell
                case 2:
                    let cell = tv.dequeueReusableCell(withIdentifier: "PriceTextFieldCell", for: IndexPath(row: row, section: 0)) as! PriceTextFieldCell
                    cell.selectionStyle = .none
                    cell.priceInputField.placeholder = data
                    cell.bind(viewModel.priceTextFieldCellViewModel)
                    return cell
                case 3:
                    let cell = tv.dequeueReusableCell(withIdentifier: "DetailWriteFormCell", for: IndexPath(row: row, section: 0)) as! DetailWriteFormCell
                    cell.selectionStyle = .none
                    cell.contentInputView.text = data
                    cell.bind(viewModel.detailWriteFormCellViewModel)
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.presentAlert
            .emit(to: self.rx.setAlert)
            .disposed(by: disposeBag)
        
        viewModel.push
            .drive(onNext: { viewModel in
                let viewController = CategoryListViewController()
                viewController.bind(viewModel)
                self.show(viewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind(to: viewModel.submitButtonTapped)
            .disposed(by: disposeBag)
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
