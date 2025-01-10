//
//  StoriesCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 19.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer

final class StoriesCell: UITableViewCell {
    
    static let reuseId = "StoriesCell"
    
    private var stories: [Storie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var onStorieCellSeclected: ((Int) -> ())?
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Colors.white
        containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 100, height: 150)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(StoriesCollectionCell.self)
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ stories: [Storie]) {
        self.stories = stories
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(containerView)
        }
    }
}

extension StoriesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as StoriesCollectionCell
        let storie = stories[indexPath.row]
        cell.update(storie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedStorie = stories[indexPath.row]
        let storieIndex = indexPath.row
        onStorieCellSeclected?(storieIndex)
        
    }
}
