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
    
    func showCategories(_ categories: [String])
    func showStories(_ stories: [Storie])
    func showProducts(_ products: [Product])
    
    func navigateToDetailScreen(_ selectedProduct: Product)
    func navigateToFeatureTogglesScreen()
    func navigateToLoginScreen()
    func navigateToCartScreen()
    func navigateToMapScreen()
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
    private var categories: [String] = []
    
    //MARK: UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StoriesCell.self, forCellReuseIdentifier: StoriesCell.reuseId)
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseId)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseId)
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseId)
        tableView.register(ProductPromoCell.self, forCellReuseIdentifier: ProductPromoCell.reuseId)
        return tableView
    }()
    
    var flagButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30.0)
        let symbol = UIImage(systemName: "flag.circle.fill", withConfiguration: configuration)?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(symbol, for: .normal)
        button.addTarget(self, action: #selector(flagButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30.0)
        let symbol = UIImage(systemName: "person.fill", withConfiguration: config)?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(symbol, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var cartButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "cart", withConfiguration: config)?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 15)
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var mapButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25.0)
        let image = UIImage(systemName: "location.fill", withConfiguration: config)?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setUpFeatureToggles()
        
        presenter?.viewDidLoad()
    }
}
//MARK: - Update View
extension MenuVC {
    func showCategories(_ categories: [String]) {
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
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(loginButton)
        view.addSubview(cartButton)
        view.addSubview(mapButton)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        loginButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        cartButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        mapButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
    func setUpFeatureToggles() {
        #if LOCAL
        view.addSubview(flagButton)
        flagButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.centerX.equalToSuperview()
        }
        #endif
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
            cell.onCellPriceButtonTapped = { [weak self] product in
                self?.bannerCellPriceButtonTapped(product)
            }
            return cell
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseId, for: indexPath) as! CategoryCell
            cell.update(categories)
            cell.onCategoryTapped = { [weak self] category in
                self?.scrollToCategory(category)
            }
            return cell
            
        case .products:
            
            let product = products[indexPath.row]
            
            if product.isPromo != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductPromoCell.reuseId, for: indexPath) as! ProductPromoCell
                cell.update(product)
                cell.onPriceButtonTapped = { [weak self ]product in
                    self?.productCellPriceButtonTapped(product)
                }
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
                cell.update(product)
                cell.onPriceButtonTapped = { [weak self ]product in
                    self?.productCellPriceButtonTapped(product)
                }
                return cell
            }
            
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
    
    func navigateToFeatureTogglesScreen() {
        let featureToggleVC = FeatureToggleVC()
        present(featureToggleVC, animated: true)
    }
    
    func navigateToLoginScreen() {
        let loginVC = LoginVC()
        present(loginVC, animated: true)
    }
    
    func navigateToCartScreen() {
        let cartVC = CartVC()
        present(cartVC, animated: true)
    }
    
    func navigateToMapScreen() {
        let mapVC = MapVC()
        present(mapVC, animated: true)
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
    
    func scrollToCategory(_ categoryDescription: String) {
        guard let category = ProductSection.from(description: categoryDescription) else { return }
        
        if let productIndex = products.firstIndex(where: { $0.category == category }) {
            let indexPath = IndexPath(row: productIndex, section: MenuSection.products.rawValue)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        } else {
            print("No products found for the category: \(categoryDescription)")
        }
    }
    
    @objc func flagButtonTapped() {
        presenter?.flagButtonTapped()
    }
    
    @objc func loginButtonTapped() {
        presenter?.loginButtonTapped()
    }
    
    @objc private func cartButtonTapped() {
        presenter?.cartButtonTapped()
    }
    
    @objc private func mapButtonTapped() {
        presenter?.mapButtonTapped()
    }
}
