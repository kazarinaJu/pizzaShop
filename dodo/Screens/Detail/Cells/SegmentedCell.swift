//
//  pizzaSizeCell.swift
//  dodo
//
//  Created by Юлия Ястребова on 11.02.2024.
//

import UIKit
import SnapKit
import DodoNetworkLayer

final class SegmentedCell: UITableViewCell {
    
    var onSizeControlTapped: ((String) -> ())?
    var onDoughControlTapped: ((String) -> ())?
    
    static let reuseID = "SegmentedCell"
    
    var sizes: [String] = []
    var dough: [String] = []
    
    private var sizeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2", "3"])
        segmentedControl.addTarget(nil, action: #selector(sizeSegmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private var doughSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1", "2"])
        segmentedControl.addTarget(nil, action: #selector(doughSegmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sizeSegmentedControlValueChanged() {
        let selectedIndex = sizeSegmentedControl.selectedSegmentIndex
        let selectedSize = sizes[selectedIndex]
        onSizeControlTapped?(selectedSize)
    }
    
    @objc private func doughSegmentedControlValueChanged() {
        let selectedDoughIndex = doughSegmentedControl.selectedSegmentIndex
        let selectedDough = dough[selectedDoughIndex]
        onDoughControlTapped?(selectedDough)
    }
    
    func update(sizes: [String], dough: [String], product: Product?, completion: @escaping (String, String)->()) {
        self.sizes = sizes
        self.dough = dough
        
        guard !sizes.isEmpty && !dough.isEmpty else { return }
        
        guard sizeSegmentedControl.numberOfSegments == sizes.count && 
              doughSegmentedControl.numberOfSegments == dough.count else { return }
        
        sizeSegmentedControl.removeAllSegments()
        doughSegmentedControl.removeAllSegments()
        
        for (index, size) in sizes.enumerated() {
            sizeSegmentedControl.insertSegment(withTitle: size, at: index, animated: false)
        }
        for (index, dough) in dough.enumerated() {
            doughSegmentedControl.insertSegment(withTitle: dough, at: index, animated: false)
        }
        
        let productSize = product?.size ?? ""
        let productDough = product?.dough ?? ""
        
        sizeSegmentedControl.selectedSegmentIndex = product?.sizeIndex(productSize) ?? 1
        doughSegmentedControl.selectedSegmentIndex = product?.doughIndex(productDough) ?? 0
        
        let defaultSize = sizes[sizeSegmentedControl.selectedSegmentIndex]
        let defaultDough = dough[doughSegmentedControl.selectedSegmentIndex]
        
        completion(defaultSize, defaultDough)
    }
    
    private func setupViews() {
        contentView.addSubview(sizeSegmentedControl)
        contentView.addSubview(doughSegmentedControl)
    }
    
    private func setupConstraints() {
        sizeSegmentedControl.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(16)
        }
        doughSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(sizeSegmentedControl.snp.bottom).offset(8)
            make.left.right.bottom.equalTo(contentView).inset(16)
        }
    }
}

