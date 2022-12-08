//
//  BlogListCell.swift
//  RxSwiftStudy
//
//  Created by 이준혁 on 2022/11/08.
//

import UIKit
import SnapKit
import Kingfisher

final class BlogListCell: UITableViewCell {
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var datetimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [
            thumbnailImageView,
            nameLabel,
            titleLabel,
            datetimeLabel
        ].forEach { contentView.addSubview($0) }
        
        thumbnailImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview().inset(8.0)
            $0.width.height.equalTo(80.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.trailing.lessThanOrEqualTo(thumbnailImageView.snp.leading).offset(-8.0)
            // lessThanOrEqualTo(100) -> 100 이상 커지지 않는다.
            // greaterThanOrEqualTo(100) -> 100 이하로 작아지지 않는다.
        }
        
        datetimeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(thumbnailImageView)
        }
        
    }
    
    // 외부에서 setData라는 func를 이용해서 데이터 형태로 표현한다.
    func setData(_ data: BlogListCellData) {
        thumbnailImageView.kf.setImage(with: data.thumbnailURL, placeholder: UIImage(systemName: "photo"))
        titleLabel.text = data.title
        nameLabel.text = data.name
        
        // Date 타입을 String으로
        var datetime: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
            let contentDate = data.datetime ?? Date()
            
            return dateFormatter.string(from: contentDate)
        }
        datetimeLabel.text = datetime
    }
}
