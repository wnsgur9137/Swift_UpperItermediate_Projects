//
//  View.swift
//  MVVM_study2
//
//  Created by 이준혁 on 2022/12/08.
//

import UIKit
import SnapKit

protocol PersonFollowingTableViewCellDelegate: AnyObject {
    func personFollowingTableViewCellDelegate(_ cell: PersonFollowingTableViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel)
}

class PersonFollowingTableViewCell: UITableViewCell {
    static let identifier = "PersonFollowingTableViewCell"
    
    weak var delegate: PersonFollowingTableViewCellDelegate?
    private var viewModel: PersonFollowingTableViewCellViewModel?
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapWithButton), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [
            userImageView,
            nameLabel,
            usernameLabel,
            button
        ].forEach{ contentView.addSubview($0) }
        
        userImageView.snp.makeConstraints {
            let widthHeight = 30.0
            $0.top.equalToSuperview().offset(10.0)
            $0.leading.equalToSuperview().offset(10.0)
            $0.height.equalTo(widthHeight)
            $0.width.equalTo(widthHeight)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.top)
            $0.leading.equalTo(userImageView.snp.trailing).offset(10.0)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.top).offset(20.0)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.bottom.equalToSuperview().offset(-10.0)
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10.0)
            $0.width.equalTo(100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapWithButton() {
        guard let viewModel = viewModel else { return }
        
        var newViewModel = viewModel
        newViewModel.currentlyFollowing = !viewModel.currentlyFollowing
        
        delegate?.personFollowingTableViewCellDelegate(self,
                                                       didTapWith: newViewModel)
        prepareForReuse()
        configure(with: newViewModel)
    }
    
    func configure(with viewModel: PersonFollowingTableViewCellViewModel) {
        self.viewModel = viewModel
        self.nameLabel.text = viewModel.name
        self.usernameLabel.text = viewModel.username
        self.userImageView.image = viewModel.image
        
        if viewModel.currentlyFollowing { // Follow -> Unfollow
            button.setTitle("Unfollow", for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
        } else { // Unfollow -> Follow
            button.setTitle("Follow", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .link
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        usernameLabel.text = nil
        userImageView.image = nil
        button.backgroundColor = nil
        button.layer.borderWidth = 0
        button.setTitle(nil, for: .normal)
    }
}
