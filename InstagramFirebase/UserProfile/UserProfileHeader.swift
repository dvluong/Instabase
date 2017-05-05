//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by David Luong on 4/7/17.
//  Copyright © 2017 Stanford Graduate School of Education. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            setupProfileImage()
            
            usernameLabel.text = user?.username
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.1)
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postsLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "following", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.7
        button.layer.cornerRadius = 4
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        setupBottomToolbar()
        addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, left: self.leftAnchor, bottom: gridButton.topAnchor, right: self.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 0)
        
        setupUserStatsView()
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        stackView.anchor(top: self.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 50)
        
    }
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        stackView.anchor(top: nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        topDividerView.anchor(top: stackView.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrl = user?.profileImageUrl else {
            self.profileImageView.image = #imageLiteral(resourceName: "plus_photo")
            return
        }
        
        guard let url = URL(string: profileImageUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch profile image: ", err)
                return
            }
            
            guard let data = data else {
                return
            }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        
        }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
