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
    var addToCartButtonView = CustomBigButton()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ImageCell.self)
        tableView.registerCell(PortionCell.self)
        tableView.registerCell(SegmentedCell.self)
        tableView.registerCell(IngredientsCell.self)
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
        addToCartButtonView.onBigButtonTapped = { [weak self] in
            guard let product = self?.product else { return }
            self?.presenter?.addToCartButtonTapped(product)
        }
    }
}

//MARK: - Layout
extension DetailVC {
    private func setupViews() {
        addToCartButtonView.accessibilityIdentifier = "Button"
        view.backgroundColor = Colors.white
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
        guard let product = product else { return 0 }
        return product.category == .pizza ? DetailSection.allCases.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = product else { return UITableViewCell() }
        
        let section: DetailSection
        if product.category == .pizza {
            section = DetailSection(rawValue: indexPath.row) ?? .image
        } else {
            section = .image
        }
        
        switch section {
        case .image:
            let cell = tableView.dequeuCell(indexPath) as ImageCell
            cell.update(product)
            cell.delegate = self
            return cell
        case .portion:
            let cell = tableView.dequeuCell(indexPath) as PortionCell
            cell.product = product
            cell.clipsToBounds = true
            return cell
        case .segment:
            let cell = tableView.dequeuCell(indexPath) as SegmentedCell
            cell.update(sizes: sizes, dough: dough, product: self.product) { [weak self] size, dough in
                self?.product?.dough = dough
                self?.product?.size = size
            }
            
            cell.onDoughControlTapped = { [weak self] dough in
                self?.doughControlCellTapped(dough)
            }
            cell.onSizeControlTapped = { [weak self] size in
                self?.sizeControlCellTapped(size)
            }
            return cell
        case .ingredient:
            let cell = tableView.dequeuCell(indexPath) as IngredientsCell
            cell.update(ingredients)
            return cell
        default: return UITableViewCell()
        }
    }
}

//MARK: - Pass Event
extension DetailVC {
    func doughControlCellTapped(_ dough: String) {
        presenter?.doughControlTapped(dough)
    }
    
    func sizeControlCellTapped(_ size: String) {
        presenter?.sizeControlTapped(size)
    }
}

extension DetailVC: ImageCellDelegate {
    func showPopover(from sourceView: UIView) {
        let popoverViewController = PopoverVC()
        popoverViewController.label.text = product?.energyValue
        popoverViewController.preferredContentSize = CGSize(width: 200, height: 100)
        popoverViewController.modalPresentationStyle = .popover
        
        if let popoverPresentationController = popoverViewController.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = .down
            popoverPresentationController.sourceRect = sourceView.bounds
            popoverPresentationController.sourceView = sourceView
            popoverPresentationController.delegate = self
        }
        
        present(popoverViewController, animated: true, completion: nil)
    }
}

extension DetailVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(
        for controller: UIPresentationController,
        traitCollection: UITraitCollection
    ) -> UIModalPresentationStyle {
        return .none
    }
}
