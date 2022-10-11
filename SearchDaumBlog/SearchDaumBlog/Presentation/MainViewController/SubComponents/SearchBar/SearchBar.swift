//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 이준혁 on 2022/10/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    private lazy var searchButton: UIButton = {
       let searchButton = UIButton()
        
        return searchButton
    }()
    
    // SearchBar 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>()   // 탭 이벤트만 전달되기에 Void로 설정
    
    // SearchBar 외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private extension SearchBar {
    
    func bind() {
        // searchBar search button tapped
        // button tapped
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(),
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) { $1 ?? "" }  // 가장 최신의 searchBar의 text
            .filter { !$0.isEmpty }// 입력되지 않으면 실행 ㄴㄴ
            .distinctUntilChanged() // 중복 제거
        
    }
    
    func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    func layout() {
        addSubview(searchButton)
        
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
}

extension Reactive where Base: SearchBar {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
