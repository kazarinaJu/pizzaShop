//
//  FeatureToggleVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 25.08.2024.
//

import UIKit
import SnapKit

class FeatureToggleVC: UIViewController {
    
    private var remoteFeatureToggles: [Feature] = []
    private var localFeatureToggles: [Feature] = []
    var featureToggleService: FeatureToggleService = FeatureToggleService.shared
    
    let remoteVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        return stackView
    }()
    
    let localVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        return stackView
    }()
    
    let mainHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 24
        return stackView
    }()
    
    let remoteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Remote Features"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let localTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Local Features"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        fetchRemoteFeature()
        fetchLocalFeature()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mainHorizontalStackView)
        mainHorizontalStackView.addArrangedSubview(createStackWithTitle(remoteTitleLabel, stackView: remoteVerticalStackView))
        mainHorizontalStackView.addArrangedSubview(createStackWithTitle(localTitleLabel, stackView: localVerticalStackView))
    }
    
    private func setupConstraints() {
        mainHorizontalStackView.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        remoteVerticalStackView.snp.makeConstraints { make in
            make.width.equalTo(localVerticalStackView)
        }
        
        localVerticalStackView.snp.makeConstraints { make in
            make.width.equalTo(remoteVerticalStackView)
        }
    }
    
    private func createStackWithTitle(_ titleLabel: UILabel, stackView: UIStackView) -> UIStackView {
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.alignment = .fill
        containerStackView.spacing = 8
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(stackView)
        
        return containerStackView
    }
    
    private func updateUI() {
        remoteVerticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        localVerticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for feature in remoteFeatureToggles {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .center
            horizontalStackView.spacing = 8
            
            let label = UILabel()
            label.text = feature.name
            
            let switchControl = UISwitch()
            switchControl.isOn = feature.enabled
            
            horizontalStackView.addArrangedSubview(label)
            horizontalStackView.addArrangedSubview(switchControl)
            remoteVerticalStackView.addArrangedSubview(horizontalStackView)
        }
        
        for feature in localFeatureToggles {
            let horizontalStackView = UIStackView()
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .center
            horizontalStackView.spacing = 8
            
            let label = UILabel()
            label.text = feature.name
            
            let switchControl = UISwitch()
            switchControl.isOn = feature.enabled
            
            horizontalStackView.addArrangedSubview(label)
            horizontalStackView.addArrangedSubview(switchControl)
            localVerticalStackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    @objc private func switchLocalToggle(_ sender: UISwitch) {
        //тут надо обновлять локальный файл
    }
    
    
    private func fetchRemoteFeature() {
        featureToggleService.fetchRemoteFeatureToggles { [weak self] featureToggles in
            guard let self = self else { return }
            
            self.remoteFeatureToggles = featureToggles ?? []
            
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    private func fetchLocalFeature() {
        featureToggleService.fetchLocalFeatureToggles { [weak self] featureToggles in
            guard let self = self else { return }
            
            self.localFeatureToggles = featureToggles ?? []
            
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
}
