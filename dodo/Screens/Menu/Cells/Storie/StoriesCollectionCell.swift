//
//  StoriesCollectionCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 19.02.2024.
//

import UIKit
import SnapKit

final class StoriesCollectionCell: UICollectionViewCell {
    static let reuseId = "StoriesCollectionCell"
    
    private var storiesImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ storie: Storie) {
        storiesImageView.image = UIImage(named: storie.image)
        
        if !storie.readability {
            contentView.layer.cornerRadius = 10
            contentView.layer.borderWidth = 4
            contentView.layer.borderColor = Colors.orange.cgColor
        } 
    }

    private func setupViews() {
        contentView.addSubview(storiesImageView)
        
        contentView.backgroundColor = Colors.white
        storiesImageView.layer.cornerRadius = 15
    }
    
    private func setupConstraints() {
        storiesImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
