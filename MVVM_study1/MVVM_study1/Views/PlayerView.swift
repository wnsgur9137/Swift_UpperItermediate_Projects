//
//  PlayerView.swift
//  MVVM_study1
//
//  Created by 이준혁 on 2022/12/08.
//

import UIKit
import SnapKit

final class PlayerView: UIView {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var transferFeeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        [
            imageView,
            nameLabel,
            ageLabel,
            transferFeeLabel
        ].forEach{ addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(200.0)
            $0.height.equalTo(200.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30.0)
            $0.leading.equalTo(imageView.snp.leading)
        }
        
        ageLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20.0)
            $0.leading.equalTo(imageView.snp.leading)
        }
        
        transferFeeLabel.snp.makeConstraints {
            $0.top.equalTo(ageLabel.snp.bottom).offset(20.0)
            $0.leading.equalTo(imageView.snp.leading)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
