//
//  PriceTextFieldCellView.swift
//  UsedGoodsUpload
//
//  Created by 이준혁 on 2022/12/09.
//

import RxSwift
import RxCocoa

struct PriceTextFieldCellViewModel {
    
    // ViewModel -> View
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    // View -> ViewModel
    let priceValue = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0" },
                freeShareButtonTapped.map { _ in false }
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
