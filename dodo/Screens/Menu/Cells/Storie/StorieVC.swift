//
//  StorieVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 09.12.2024.
//

import UIKit

protocol StorieVCProtocol: AnyObject {
    var presenter: StoriePresenterProtocol? { get set }
    var imageView: UIImageView { get set }
    var progressViews: [AppProgressView] { get set }
    var onStorieWatched: (() -> ())? { get set }
    var onStorieReadable: (() -> ())? { get set }
    
    func resetProgress(for index: Int)
    func isProgressComplete(for index: Int) -> Bool
}

final class StorieVC: UIViewController, StorieVCProtocol {
    var presenter: StoriePresenterProtocol?
    var imageView = UIImageView()
    var progressViews: [AppProgressView] = []
    var onStorieWatched: (() -> ())?
    var onStorieReadable: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupGestures()
        setupProgressBars()
        updateImage()
        presenter?.startProgress(for: presenter?.currentIndex ?? 0)
    }
    
    private func setupViews() {
        view.backgroundColor = Colors.black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupProgressBars() {
        let progressStackView = UIStackView()
        progressStackView.axis = .horizontal
        progressStackView.spacing = 4
        progressStackView.alignment = .fill
        progressStackView.distribution = .fillEqually
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressStackView)
        
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(4)
        }
        
        for _ in presenter?.stories ?? [] {
            let progressView = AppProgressView()
            progressStackView.addArrangedSubview(progressView)
            progressViews.append(progressView)
        }
    }
    
    private func setupGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(nextImage))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(previousImage))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeImage))
        view.addGestureRecognizer(tapGesture)
    }
    
    func updateImage() {
        presenter?.showCurrentImage()
    }
    
    @objc private func nextImage() {
        presenter?.goToNextStorie()
    }
    
    @objc private func previousImage() {
        presenter?.goToPreviousStorie()
    }
    
    @objc private func closeImage() {
        presenter?.dismissStorie()
    }
    
    func resetProgress(for index: Int) {
        progressViews[index].progress = 1.0
    }
    
    func isProgressComplete(for index: Int) -> Bool {
        return progressViews[index].progress >= 1.0
    }
}
