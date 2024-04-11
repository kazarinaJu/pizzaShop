//
//  DetailVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 08.02.2024.
//

import UIKit
import SnapKit

protocol DetailVCProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    
    func showIngredients(_ ingredients: [Ingredient])
    func showSizes(_ sizes: [String])
    func showDough(_ dough: [String])
    func showProduct(_ product: Product?)
}

final class DetailVC: UIViewController, DetailVCProtocol {
    
    enum DetailSection: Int, CaseIterable {
        case image
        case portion
        case segment
        case ingredient
    }
    
    var presenter: DetailPresenterProtocol?
    var product: Product?
    
    private var ingredients: [Ingredient] = []
    private var sizes: [String] = []
    private var dough: [String] = []

//MARK: UI
    private var addToCartButtonView = CustomBigButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseID)
        tableView.register(PortionCell.self, forCellReuseIdentifier: PortionCell.reuseID)
        tableView.register(SegmentedCell.self, forCellReuseIdentifier: SegmentedCell.reuseID)
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.reuseID)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        observe()
        presenter?.viewDidLoad()
    }
}

//MARK: - Update View
extension DetailVC {
    func showIngredients(_ ingredients: [Ingredient]) {
        self.ingredients = ingredients
        tableView.reloadData()
    }
    
    func showSizes(_ sizes: [String]){
        self.sizes = sizes
        tableView.reloadData()
    }
    
    func showDough(_ dough: [String]){
        self.dough = dough
        tableView.reloadData()
    }
    
    func showProduct(_ product: Product?) {
        self.product = product
        addToCartButtonView.customBigtButton.setTitle("В корзину за \(product?.price ?? 0) ₽", for: .normal)
        tableView.reloadData()
    }
}

//MARK: - Observe
extension DetailVC {
    func observe() {
        addToCartButtonView.onBigButtonTapped = {
            guard let product = self.product else { return }
            self.presenter?.addToCartButtonTapped(product)
        }
    }
}

//MARK: - Layout
extension DetailVC {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(addToCartButtonView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view)
        }
        
        addToCartButtonView.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(16)
            make.bottom.equalTo(view)
        }
    }
}

//MARK: - UITableViewDelegate
extension DetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = DetailSection.init(rawValue: indexPath.row)
        
        switch section {
        case .portion:
            if product?.portion == nil {
                return 0
            }
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
}

//MARK: - UITableViewDataSource
extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = DetailSection.init(rawValue: indexPath.row)
        
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseID, for: indexPath) as! ImageCell
            cell.product = product
            return cell
        case .portion:
            let cell = tableView.dequeueReusableCell(withIdentifier: PortionCell.reuseID, for: indexPath) as! PortionCell
            cell.product = product
            cell.clipsToBounds = true
            return cell
        case .segment:
            let cell = tableView.dequeueReusableCell(withIdentifier: SegmentedCell.reuseID, for: indexPath) as! SegmentedCell
            
            cell.update(sizes: sizes, dough: dough, product: self.product) { size, dough in
                self.product?.dough = dough
                self.product?.size = size
            }
            
            cell.onDoughControlTapped = { dough in
                self.presenter?.doughControlTapped(dough)
            }
            cell.onSizeControlTapped = { size in
                self.presenter?.sizeControlTapped(size)
            }
            return cell
        case .ingredient:
            let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.reuseId, for: indexPath) as! IngredientsCell
            
            cell.update(ingredients)
            return cell
        default: return UITableViewCell()
        }
    }
}
