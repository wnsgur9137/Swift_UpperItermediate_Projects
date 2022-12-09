//
//  DetailWriteFormCellViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이준혁 on 2022/12/09.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    
    // View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
