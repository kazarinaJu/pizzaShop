//
//  StorieVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 09.12.2024.
//

import UIKit

final class StorieVC: UIViewController {
    private var stories: [Storie]
    private var currentIndex: Int
    private let imageView = UIImageView()
    private var progressViews: [AppProgressView] = []
    private var progressTimers: [Timer?]
    
    var onStoriesUpdated: (([Storie]) -> ())?
    
    init(stories: [Storie], currentIndex: Int) {
        self.stories = stories
        self.currentIndex = currentIndex
        self.progressTimers = Array(repeating: nil, count: stories.count)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupGestures()
        setupProgressBars()
        showCurrentImage()
        startProgress(for: currentIndex)
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
       
        for _ in stories {
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func showCurrentImage() {
        let currentStorie = stories[currentIndex]
        imageView.image = UIImage(named: currentStorie.image)
    }
    
    @objc private func nextImage() {
        stopCurrentProgress()
        
        stories[currentIndex].readability = true
        
        if currentIndex < stories.count - 1 {
            currentIndex += 1
            showCurrentImage()
            startProgress(for: currentIndex)
        } else {
            dismissSelf()
        }
    }
    
    @objc private func previousImage() {
        stopCurrentProgress()
        
        stories[currentIndex].readability = true
        
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        showCurrentImage()
        startProgress(for: currentIndex)
    }
    
    @objc private func dismissSelf() {
        stories[currentIndex].readability = true
        onStoriesUpdated?(stories)
        dismiss(animated: true, completion: nil)
    }
    
    private func startProgress(for index: Int) {
        stopCurrentProgress()
        
        let duration: TimeInterval = 5.0
        progressViews[index].progress = 0.0
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            let increment = Float(0.05 / duration)
            self.progressViews[index].progress += increment
            
            if self.progressViews[index].progress >= 1.0 {
                timer.invalidate()
                self.nextImage()
            }
        }
            progressTimers[index] = timer
    }
    
    private func stopCurrentProgress() {
        progressTimers[currentIndex]?.invalidate()
        progressTimers[currentIndex] = nil
    }
}
