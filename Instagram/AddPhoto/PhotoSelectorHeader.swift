//
//  PhotoSelectorHeader.swift
//  Instagram
//
//  Created by Angela Terao on 30/08/2023.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    
    let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerImageView)
        headerImageView.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, height: nil, width: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
