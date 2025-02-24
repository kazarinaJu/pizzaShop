//
//  AddressVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 17.02.2025.
//

import UIKit
import SnapKit

class AddressVC: UIViewController {
    
    private var addresses: [Suggestion] = []
    private let dadataService = DadataService()
    var timer: Timer?
    var delayValue: Double = 1.0
    
    var onAddressSelected: ((String) -> ())?
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.backgroundColor = .white
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.black.cgColor
        field.font = UIFont.boldSystemFont(ofSize: 15)
        field.layer.cornerRadius = 20
        field.placeholder = "Введите адрес"
        field.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        return field
    }()
    
    lazy var tableView: UITableView = {
        var table = UITableView()
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.register(AddressCell.self, forCellReuseIdentifier: AddressCell.reuseId)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        observe()
    }
    
    private func fetchAddresses(query: String) {
        dadataService.fetchAddress(query) { [weak self] addresses in
            DispatchQueue.main.async {
                self?.addresses = addresses.map { Suggestion(value: $0, unrestrictedValue: $0) }
                self?.tableView.reloadData()
            }
        }
    }
    
    func observe() {
        textField.addTarget(nil, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldChanged(_ sender: UITextField) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    @objc func timerAction() {
        if let text = textField.text {
            fetchAddresses(query: text)
        }
    }
    
    func setupViews(){
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(tableView)
    }
    
    func setupConstraints(){
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}

extension AddressVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseId, for: indexPath) as! AddressCell
        let address = addresses[indexPath.row]
        cell.update(address.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAddress = addresses[indexPath.row].value
        onAddressSelected?(selectedAddress)
    }
}
