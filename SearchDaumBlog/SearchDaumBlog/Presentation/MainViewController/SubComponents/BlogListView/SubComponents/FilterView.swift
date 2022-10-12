//
//  FilterView.swift
//  SearchDaumBlog
//
//  Created by 이준혁 on 2022/10/12.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class FilterView: UITableViewHeaderFooterView {
    let disposeBag = DisposeBag()
    
    private lazy var sortButton: UIButton = {
        let sortButton = UIButton()

        return sortButton
    }()

    private lazy var bottomBorder: UIView = {
        let bottomBorder = UIView()

        return bottomBorder
    }()
    
    // FilterView 외부에서 관찰
    let sortButtonTapped = PublishRelay<Void>()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FilterView {
    
    func bind() {
        sortButton.rx.tap
            .bind(to: sortButtonTapped)
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        sortButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        bottomBorder.backgroundColor = .lightGray
    }
    
    func layout() {
        [sortButton, bottomBorder].forEach{ addSubview($0) }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
            $0.width.height.equalTo(28)
        }
        
        bottomBorder.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.2)
        }
    }
}
