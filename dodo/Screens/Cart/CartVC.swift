//
//  CartVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 01.02.2024.
//
import UIKit

protocol CartVCProtocol: AnyObject {
    var presenter: CartPresenterProtocol? { get set }
    
    func showProducts(_ products: [Product])
    func show(_ offerProducts: [Product])
    func showCart(_ totalPrice: Int, _ totalProducts: Int)
}

final class CartVC: UIViewController, CartVCProtocol {

    enum OrderSection: Int, CaseIterable {
        case products
        case offer
        case detail
    }
    
    var presenter: CartPresenterProtocol?
    private var orderProducts: [Product] = []
    private var offerProducts: [Product] = []
    
//MARK: UI
    private var priceOrderButton = CustomBigButton()
    private var emptyCart = EmptyCart()
    
    private lazy var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        let priceHeaderView = PriceHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        tableView.tableHeaderView = priceHeaderView
        priceHeaderView.priceLabel.text = "5 товаров на 100 ₽"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderProductCell.self, forCellReuseIdentifier: OrderProductCell.reuseId)
        tableView.register(OrderDetailCell.self, forCellReuseIdentifier: OrderDetailCell.reuseId)
        tableView.register(BannerCell.self, forCellReuseIdentifier: BannerCell.reuseId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrain()
        observe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

//MARK: - Update View
extension CartVC {
    func showProducts(_ products: [Product]) {
        self.orderProducts = products
        cartUpdated()
    }
    
    func showCart(_ totalPrice: Int, _ totalProducts: Int) {
        let text = "\(totalProducts) товаров на \(totalPrice) ₽"
        if let priceHeaderView = cartTableView.tableHeaderView as? PriceHeaderView {
            priceHeaderView.priceLabel.text = text
        }
        priceOrderButton.customBigtButton.setTitle("Оформить заказ на \(totalPrice) ₽", for: .normal)
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
    
    func show(_ offerProducts: [Product]) {
        self.offerProducts = offerProducts
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
}

//MARK: - Layout
extension CartVC {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(cartTableView)
        view.addSubview(priceOrderButton)
        view.addSubview(emptyCart)
    }
    
    private func setupConstrain() {
        cartTableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(priceOrderButton.snp.top)
        }
        priceOrderButton.snp.makeConstraints { make in
            make.left.right.equalTo(view).inset(8)
            make.bottom.equalTo(view).inset(50)
        }
        emptyCart.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

//MARK: - Observe
extension CartVC {
    private func observe() { //bind
        emptyCart.onGoToMenuTapped = { [weak self] in
            self?.goToMenu()
        }
    }
}

//MARK: - UITableViewDelegate
extension CartVC: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension CartVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return OrderSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let orderSection = OrderSection.init(rawValue: section)
        
        switch orderSection {
        case .products:
            emptyCart.isHidden = orderProducts.isNotEmpty
            return orderProducts.count
        case .offer:
            return 1
        case .detail:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderSection = OrderSection.init(rawValue: indexPath.section)
        
        switch orderSection {
        case .products:
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderProductCell.reuseID, for: indexPath) as! OrderProductCell
            let product = orderProducts[indexPath.row]
            cell.update(product)
            cell.onProductCountChanged = { [weak self] changedProduct in
                self?.productCountChangedHappened(changedProduct)
            }
            return cell
            
        case .offer:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerCell.reuseId, for: indexPath) as! BannerCell
            cell.update(offerProducts)
            cell.bannerLabel.text = "Добавить к заказу?"
            cell.onCellPriceButtonTapped = { [weak self] product in
                self?.offerCellPriceButtonTapped(product)
            }
            return cell

        case .detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailCell.reuseID, for: indexPath) as! OrderDetailCell
            guard let price = presenter?.totalPrice else { return cell }
            guard let count = presenter?.totalProducts else { return cell }
            cell.update(count, price)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - Pass Event
extension CartVC {
    func productCountChangedHappened(_ changedProduct: Product) {
        presenter?.productCountChanged(&orderProducts, changedProduct)
    }
    
    func cartUpdated() {
        presenter?.updateCart()
    }
    
    func offerCellPriceButtonTapped(_ product: Product) {
        presenter?.offerPriceButtonTapped(product)
    }
    
    private func goToMenu() {
        dismiss(animated: true, completion: nil)
    }
}
