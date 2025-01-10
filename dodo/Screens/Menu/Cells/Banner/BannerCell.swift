//
//  BannerCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 17.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer

final class BannerCell: UITableViewCell {
    
    var onCellPriceButtonTapped: ((Product)->Void)?
    
    static let reuseId = "BannerCell"
    
    private var products: [Product] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var ordersService: OrdersStorageProtocol?
    
    private var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = Colors.white
        containerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    var bannerLabel = CustomLabel.leftRoundedBold22
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: ScreenSize.width * 0.6, height: ScreenSize.width * 0.25)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 8)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerCell(BannerCollectionCell.self)
        
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
    
    func update(_ products: [Product]) {
        self.products = products.filter { $0.isOnSale }
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubview(bannerLabel)
        containerView.addSubview(collectionView)
        
        bannerLabel.text = Texts.Menu.bannerTitle
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.bottom.equalTo(contentView).inset(8)
        }
        bannerLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(containerView).inset(8)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bannerLabel.snp.bottom)
            make.left.right.bottom.equalTo(containerView)
        }
    }
}

extension BannerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as BannerCollectionCell
        let product = products[indexPath.row]
        cell.update(product)
        cell.onPriceButtonTapped = { [weak self] product in
            self?.onCellPriceButtonTapped?(product)
        }
        return cell
    }
}
