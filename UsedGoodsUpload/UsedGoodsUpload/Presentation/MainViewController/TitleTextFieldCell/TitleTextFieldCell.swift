//
//  TitleTextFieldCell.swift
//  UsedGoodsUpload
//
//  Created by 이준혁 on 2022/11/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TitleTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    private lazy var titleInputField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17.0)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleTextFieldCellViewModel) {
        titleInputField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }
}

private extension TitleTextFieldCell {
    func attribute() {
        
    }
    
    func layout() {
        contentView.addSubview(titleInputField)
        
        titleInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
    }
}
