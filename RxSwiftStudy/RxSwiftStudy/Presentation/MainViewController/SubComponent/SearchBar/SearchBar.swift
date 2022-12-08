//
//  SearchBar.swift
//  RxSwiftStudy
//
//  Created by 이준혁 on 2022/11/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

// 텍스트를 입력받고, MainViewController에게 전달(listView에게 전달)

final class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    // SearchBar 버튼 탭 이벤트
    // error Event를 받지 않고 UI이벤트에 특화된 PublishRelay
    // 버튼 탭은 UI 이벤트이므로 PublishRelay를 사용한다.
    // 탭 이벤트만 전달하기에 Void로 선언하였다.
    let searchButtonTapped = PublishRelay<Void>()
    
    // SearchBar 외부로 내보낼 이벤트
    // SearchBar에(TextField) 들어오는 값이 Text이므로 String 반환
    var shouldLoadResult = Observable<String>.of("")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bind() {
        // SearchBar의 Search button tapped -> 키보드의 엔터 버튼
        // button Tapped -> 검색 버튼을 따로만들은 것(searchButton)
        // 이 둘을 merge로 사용한다.
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(), // Observable로 만들었으므로 asObservable로 타입 변환
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        // serachButtonTapped가 발생하면 EndEditing
        // asSignal, asDriver는 메인쓰레드에서 동작을 보장하고, error을 반환하지 않는다.
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        // searchButtonTapped 했을 때 가장 최신의 Text를 전달한다.
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }
            .filter{ !$0.isEmpty }  // 빈 값을 보내지 않기 위해 filter 처리한다.
            .distinctUntilChanged() // 동일한 조건을 계속해서 보내지 않기 위해 사용한다.(연달아 중복된 값이 올 때 무시한다.)
    }
    
    private func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12.0)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12.0)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.0)
        }
    }
}

// SearchBar의 EndEditing 커스텀
extension Reactive where Base: SearchBar {
    // RxCocoa의 Binder를 사용하면 값의 변화에 따라 화면의 일부 View에 쉽게 반영한다.
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
            // 여기서 base는 SearchBar를 의미한다.
        }
    }
}
