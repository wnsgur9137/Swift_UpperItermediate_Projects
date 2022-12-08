//
//  MainViewController.swift
//  RxSwiftStudy
//
//  Created by 이준혁 on 2022/11/08.
//

import RxSwift
import RxCocoa
import UIKit
import SnapKit

final class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let searchBar = SearchBar()
    let listView = BlogListView()
    
    // Alert Action에 해당 하단 extension과 AlertActionConvertible 참고
    let alertActionTapped = PublishRelay<AlertAction>()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // RxCodes
    private func bind() {
        
        // sortButton이 눌리게 되면.
        // alertSheet를 표현
        let alertSheetForSorting = listView.headerView.sortButtonTapped
            .map{ _ -> Alert in  // 처음에는 Void지만 탭되게 되면 Alert로 바꿔준다.
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        alertSheetForSorting
            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest { alert -> Signal<AlertAction> in
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: alertActionTapped)
            .disposed(by: disposeBag)
    }
    
    // View의 attribute
    private func attribute() {
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }
    
    // layout
    private func layout() {
        [
            searchBar,
            listView
        ].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// Alert
extension MainViewController {
    typealias Alert = (
        title: String?,
        message: String?,
        actions: [UIAlertAction],
        style: UIAlertController.Style
    )
    
    enum AlertAction: AlertActionConvertible {
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title:
                return "Title"
            case .datetime:
                return "Datetime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
            case .cancel, .confirm:
                return .cancel
            }
        }
    }
    
    func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty { return .empty() }
        return Observable
            .create {[weak self] observer in
                // create는 직접 Observable 시퀀스를 구성할 때 사용한다.
                guard let self = self else { return Disposables.create() }
                for action in actions {
                    alertController.addAction(
                        UIAlertAction(
                            title: action.title,
                            style: action.style,
                            handler: { _ in
                                observer.onNext(action)
                                observer.onCompleted()
                            }
                        )
                    )
                }
                self.present(alertController, animated: true, completion: nil)
                return Disposables.create {
                    alertController.dismiss(animated: true, completion: nil)
                }
            }
            .asSignal(onErrorSignalWith: .empty())
    }
}
