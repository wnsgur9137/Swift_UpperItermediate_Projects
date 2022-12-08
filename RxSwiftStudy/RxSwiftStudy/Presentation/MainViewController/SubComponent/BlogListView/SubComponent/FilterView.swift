//
//  FilterView.swift
//  RxSwiftStudy
//
//  Created by 이준혁 on 2022/11/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class FilterView: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        return button
    }()
    
    // 자연스럽게 보이기 위한 경계선
    private lazy var bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // FilterView를 외부에서 '관찰'
    let sortButtonTapped = PublishRelay<Void>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        sortButton.rx.tap
            .bind(to: sortButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func layout() {
        [
            sortButton,
            bottomBorder
        ].forEach { addSubview($0) }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.0)
            $0.width.height.equalTo(28.0)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
