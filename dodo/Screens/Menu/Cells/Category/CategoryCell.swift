//
//  CategoryCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 21.02.2024.
//

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    static let reuseId = "CategoryCell"
    
    //var onCategoryTapped: ((Category)->())? //declaration closure
    
//    private var categories: [Category] = [] {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
    
    private var productSections: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.reuseId)
        
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
    
//    func update(_ categories: [Category]) {
//        self.categories = categories
//    }
    
    func update(_ productSections: [String]) {
        self.productSections = productSections
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

extension CategoryCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return categories.count
        return productSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseId, for: indexPath) as! CategoryCollectionCell
        //let category = categories[indexPath.row]
        //cell.update(category)
        
        let productSection = productSections[indexPath.row]
        cell.update(with: productSection)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let category = categories[indexPath.row]
//        onCategoryTapped?(category) //call closure
        let productSection = productSections[indexPath.row]
    }
}
