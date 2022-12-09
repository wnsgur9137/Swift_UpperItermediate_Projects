//
//  CategoryViewModel.swift
//  UsedGoodsUpload
//
//  Created by 이준혁 on 2022/11/30.
//

import RxSwift
import RxCocoa

struct CategoryViewModel {
    let disposeBag = DisposeBag()
    
    // ViewModel이 View에게 전달
    let cellData: Driver<[Category]>
    
    // pop 이벤트를 읽어야 한다.
    // View -> ViewModel
    let pop: Signal<Void>
    
    // 선택된 카테고리가 무엇인지 row값을 받아야 한다.
    // ViewModel -> ParentsViewModel
    let itemSelected = PublishRelay<Int>()
    
    // MainViewController가 받기 위해 전달한다.
    let selectedCategory = PublishSubject<Category>()
    
    init() {
        let categories = [
            Category(id: 1, name: "디지털/가전"),
            Category(id: 2, name: "게임"),
            Category(id: 3, name: "스포츠/레저"),
            Category(id: 4, name: "유아/아동용품"),
            Category(id: 5, name: "여성패션/잡화"),
            Category(id: 6, name: "뷰티/미용"),
            Category(id: 7, name: "남성패션/잡화"),
            Category(id: 8, name: "생활/식품"),
            Category(id: 9, name: "가구"),
            Category(id: 10, name: "도서/티켓/취미"),
            Category(id: 11, name: "기타")
        ]
        
        // 데이터 전달
        self.cellData = Driver.just(categories)
        
        self.itemSelected
            .map { categories[$0] } // row에 해당하는 카테고리로 변환
            .bind(to: selectedCategory) // 내보낸다.
            .disposed(by: disposeBag)
        
        self.pop = itemSelected
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
    }
}
