//
//  RepositoryListCell.swift
//  GitHubRepository
//
//  Created by 이준혁 on 2022/10/10.
//

import UIKit
import SnapKit

final class RepositoryListCell: UITableViewCell {
    var repository: Repository?
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = repository?.name
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        return nameLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = repository?.description
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 2
        
        return descriptionLabel
    }()
    
    private lazy var starImageView: UIImageView = {
        let starImageView = UIImageView()
        starImageView.image = UIImage(systemName: "star")
        
        return starImageView
    }()
    
    private lazy var starLabel: UILabel = {
        let starLabel = UILabel()
        starLabel.text = "\(repository?.stargazersCount)"
        starLabel.font = .systemFont(ofSize: 16)
        starLabel.textColor = .gray
        
        return starLabel
    }()
    
    private lazy var languageLabel: UILabel = {
        let languageLabel = UILabel()
        languageLabel.text = repository?.language
        languageLabel.font = .systemFont(ofSize: 16)
        languageLabel.textColor = .gray
        
        return languageLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setUpLayout()
    }
}

extension RepositoryListCell {
    func setUpLayout() {
        [
            nameLabel, descriptionLabel,
            starImageView, starLabel, languageLabel
        ].forEach {
            contentView.addSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(descriptionLabel.snp.leading)
//            $0.leading.equalTo(descriptionLabel) // 위 코드와 동일 (생략 가능)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView.snp.centerY)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        languageLabel.snp.makeConstraints {
            $0.centerY.equalTo(starLabel.snp.centerY)
            $0.leading.equalTo(starLabel.snp.trailing).offset(12)
        }
    }
}
