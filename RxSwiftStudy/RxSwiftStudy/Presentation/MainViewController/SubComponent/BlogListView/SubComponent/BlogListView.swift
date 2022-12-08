//
//  BlogListView.swift
//  RxSwiftStudy
//
//  Created by 이준혁 on 2022/11/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class BlogListView: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(
        frame: CGRect(
            origin: .zero,
            size: CGSize(
                width: UIScreen.main.bounds.width,   // 어떤 디바이스가 와도 좌우 풀로 차지.
                height: 50.0
            )
        )
    )
    
    // MainViewController(부모 View) -> BlogListView
    let cellData = PublishSubject<[BlogListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func bind() {
        
        // UITableViewDelegate 함수 중 cellForRowAt Delegate 함수를 Rx로 표현한 것.
        // 만약에 MainViewController가 CellData를 보낼 경우
        cellData
            // UI에 해당하기 때문에 Observable을 사용
            .asDriver(onErrorJustReturn: [])    // 만약에 Error일 경우 빈 Array를 전달(반환)
            .drive(self.rx.items) { tv, row, data in
                // items는 데이터를 받아서 어떻게 전달할 것인지를 의미한다.
                let index = IndexPath(row: row, section: 0) // 첫 번째 section의 전달받는 row값에 따라 row 값을 만든다.
                let cell = tv.dequeueReusableCell(withIdentifier: "blogListCell", for: index) as! BlogListCell
                cell.setData(data) // MainViewController에서 받은 Data(BlogListCellData)를 blogListCell에 전달한다.
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .white
        self.register(BlogListCell.self, forCellReuseIdentifier: "BlogListCell")
        self.separatorStyle = .singleLine
        self.rowHeight = 100.0
        self.tableHeaderView = headerView
    }
}
