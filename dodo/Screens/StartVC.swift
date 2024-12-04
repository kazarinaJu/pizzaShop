//
//  StartVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 03.10.2024.
//

import Foundation
import UIKit
import SnapKit

final class StartVC: UIViewController {
    
    var onTogglesPreloaded: ((Bool) -> ())?
    
    let remoteToggleService = RemoteTogglesService.shared
    let localToggleService = LocalTogglesService.shared
    
    private var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.splash
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        loadToggles()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(splashImageView)
    }
    
    private func setupConstraints() {
        splashImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.center)
            make.centerY.equalTo(view.center)
            make.width.height.equalTo(view)
        }
    }
    
    private func loadToggles() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        localToggleService.fetchLocalFeatureToggles { success in
            print("Local toggles loaded: \(success)")
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        remoteToggleService.fetchToggles { success in
            print("Remote toggles loaded: \(success)")
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { //[weak self] in
            //guard let self else { return }

            self.onTogglesPreloaded?(true)
        }
    }
}
