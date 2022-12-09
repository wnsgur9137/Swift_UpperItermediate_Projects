//
//  DetailWriteFormCell.swift
//  UsedGoodsUpload
//
//  Created by 이준혁 on 2022/12/09.
//

import UIKit
import RxCocoa
import RxSwift

class DetailWriteFormCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let contentInputView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailWriteFormCell {
    func bind(_ viewModel: DetailWriteFormCellViewModel) {
        contentInputView.rx.text
            .bind(to: viewModel.contentValue)
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        contentInputView.font = .systemFont(ofSize: 17.0)
    }
    
    func layout() {
        contentView.addSubview(contentInputView)
        
        contentInputView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.height.equalTo(300.0)
        }
    }
}
