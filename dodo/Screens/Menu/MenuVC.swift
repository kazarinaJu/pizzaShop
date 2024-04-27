//
//  ViewController.swift
//  dodo
//
//  Created by Юлия Ястребова on 26.01.2024.
//

import UIKit
import SnapKit

protocol MenuVCProtocol: AnyObject {
    var presenter: MenuPresenterProtocol? { get set }
    
    func showCategories(_ categories: [Category])
    func showStories(_ stories: [Storie])
    func showProducts(_ products: [Product])
    
    func navigateToDetailScreen(_ selectedProduct: Product)
}

final class MenuVC: UIViewController, MenuVCProtocol {
    
    var presenter: MenuPresenterProtocol?
    
    enum MenuSection: Int, CaseIterable {
        case stories
        case banners
        case categories
        case products
    }
    
    //MARK: Data models
    private var stories: [Storie] = []
    private var products: [Product] = []
    private var categories: [Category] = []
    
    //MARK: UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseId)
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseId)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseId)
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        presenter?.viewDidLoad()
    }
}
//MARK: - Update View
extension MenuVC {
    func showCategories(_ categories: [Category]) {
        self.categories = categories
        tableView.reloadData()
    }
    
    func showStories(_ stories: [Storie]) {
        self.stories = stories
        tableView.reloadData()
    }
    
    func showProducts(_ products: [Product]) {
        self.products = products
        tableView.reloadData()
    }
}

//MARK: - Layout
extension MenuVC {
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - UITableViewDataSource
extension MenuVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = MenuSection.init(rawValue: section)
        
        switch section {
        case .stories: return 1
        case .banners: return 1
        case .categories: return 1
        case .products: return products.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = MenuSection.init(rawValue: indexPath.section)
        
        switch section {
        case .stories:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoriesCell.reuseId, for: indexPath) as! StoriesCell
            cell.update(stories)
            return cell
        case .banners:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.reuseId, for: indexPath) as! BannerCell
            cell.update(products)
            cell.onCellPriceButtonTapped = { product in
                self.bannerCellPriceButtonTapped(product)
            }
            return cell
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            cell.update(categories)
            cell.onCategoryTapped = { category in
                let indexPath = IndexPath(row: category.indexPath[1], section: category.indexPath[0])
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            return cell
        case .products:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
            let product = products[indexPath.row]
            cell.update(product)
            cell.onPriceButtonTapped = { product in
                self.productCellPriceButtonTapped(product)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
//MARK: - UITableViewDelegate
extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = MenuSection.init(rawValue: indexPath.section)
        
        if section == .products {
            let selectedProduct = products[indexPath.row]
            productSelectedTapped(selectedProduct)
        }
    }
}

//MARK: - Navigation
extension MenuVC {
    func navigateToDetailScreen(_ selectedProduct: Product) {
        let productDetailVC = DetailConfigurator().configure(selectedProduct)
        present(productDetailVC, animated: true)
    }
}

//MARK: - Pass Event
extension MenuVC {
    func bannerCellPriceButtonTapped(_ product: Product) {
        presenter?.bannerPriceButtonTapped(product)
    }
    
    func productCellPriceButtonTapped(_ product: Product) {
        presenter?.productPriceButtonTapped(product)
    }
    
    func productSelectedTapped(_ selectedProduct: Product) {
        presenter?.productCellSelected(selectedProduct)
    }
}
