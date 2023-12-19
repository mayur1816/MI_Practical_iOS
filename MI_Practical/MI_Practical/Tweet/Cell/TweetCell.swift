//
//  TweetCell.swift
//  MI_Practical
//
//  Created by SLS M2 on 19/12/23.
//

import Foundation
import UIKit

protocol TweetCellDelegate: AnyObject {
    func didTapCommentButton(_ cell: TweetCell)
    func didTapShareButton(_ cell: TweetCell)
}

class TweetCell: UITableViewCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let tweetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "comment"), for: .normal)
        
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share"), for: .normal)
        return button
    }()
    
    weak var delegate: TweetCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupViews()
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
       
    }
    
    private func setupViews() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(tweetImageView)
        addSubview(commentButton)
        addSubview(shareButton)
        
    
        tweetImageView.layer.cornerRadius = 8
        tweetImageView.layer.masksToBounds = true
        commentButton.isUserInteractionEnabled = true
        shareButton.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -8),
            
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            tweetImageView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            tweetImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            tweetImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            
            commentButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10),
            commentButton.topAnchor.constraint(equalTo: tweetImageView.bottomAnchor, constant: 8),
            commentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            commentButton.heightAnchor.constraint(equalToConstant: 25),
            commentButton.widthAnchor.constraint(equalToConstant: 25),
            
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            shareButton.topAnchor.constraint(equalTo: tweetImageView.bottomAnchor, constant: 8),
            shareButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            shareButton.heightAnchor.constraint(equalToConstant: 25),
            shareButton.widthAnchor.constraint(equalToConstant: 25),
            
            
        ])
    }
    
    @objc func commentButtonTapped( sender :UIButton)
    {
        print("Comment button tapped")
        delegate?.didTapCommentButton(self)
    }
    
    
    @objc private func shareButtonTapped() {
        print("Share button tapped")
        delegate?.didTapShareButton(self)
    }
    
    func configure(with tweet: Tweet) {
        profileImageView.image = UIImage(named: "placeholder")
        usernameLabel.text = tweet.username
        titleLabel.text = tweet.title
        descriptionLabel.text = tweet.description
        tweetImageView.image = tweet.image
        
        if let image = tweet.image {
            tweetImageView.image = image
            let aspectRatio = image.size.width / image.size.height
            tweetImageView.heightAnchor.constraint(equalTo: tweetImageView.widthAnchor, multiplier: 1.0 / aspectRatio).isActive = true
        } else {
            tweetImageView.image = nil
            tweetImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
         
         shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)

    }
}
