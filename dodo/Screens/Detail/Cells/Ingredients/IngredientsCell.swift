//
//  IngredientsCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 10.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer

final class IngredientsCell: UITableViewCell {
    
    static let reuseId = "IngredientsCell"
    
    private var ingredients: [Ingredient] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var itemSize = CGSize(width: 0, height: 0)

    lazy private var collectionView: UICollectionView = {
        let itemsCount: CGFloat = 3
        let padding: CGFloat = 20
        let paddingCount: CGFloat = itemsCount + 1
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        
        let paddingSize = paddingCount * padding
        let cellSize = (ScreenSize.width - paddingSize) / itemsCount
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize.init(width: cellSize, height: cellSize * 2)
        itemSize = layout.itemSize
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.backgroundView = UIView.init(frame: CGRect.zero)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerCell(IngredientCollectionCell.self)
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private var titleLabel = CustomLabel.leftRoundedBold22

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ ingredients: [Ingredient]) {
        
        guard ingredients.count > 0 else { return }
        
        self.ingredients = ingredients
        var rowCount = CGFloat(ingredients.count) / 3
        rowCount.round(.up)
        
        let padding = 12
        let resultPadding = CGFloat((Int(rowCount) + 1) * padding)
        let rowHeight = CGFloat(itemSize.height + resultPadding)
        let resultHeight = CGFloat(rowCount * rowHeight)
        
        collectionView.heightAnchor.constraint(equalToConstant: resultHeight).isActive = true
    }
    
    private func setupViews() {
        //selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        titleLabel.text = Texts.Menu.ingredientsTitle
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(18)
            make.left.right.equalTo(contentView).inset(18)
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
        }
    }
}

extension IngredientsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as IngredientCollectionCell
        cell.backgroundColor = Colors.white
        let ingredient = ingredients[indexPath.row]
        cell.update(ingredient)
        return cell
    }
}
