//
//  MapVC.swift
//  dodo
//
//  Created by Юлия Ястребова on 30.03.2024.
//

import UIKit
import SnapKit
import MapKit
import Kingfisher

final class MapVC: UIViewController {
    
    var onAddressSelected: ((String) -> ())?
    
    var bottomConstraint: NSLayoutConstraint?
    var originalConstant: CGFloat = 0
    var keyboardFrame: CGRect = .zero
    
    var locationService = LocationService()
    var geocodeService = GeocodeService()
    let adressStorage = AddressStorage()
    
    let addressPanelView = AddressPanelView()
    
    var pinImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.kf.setImage(with: Images.pinUrl)
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        return imageView
    }()
    
    lazy var mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    private var closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(nil, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupKeyboardNotifications()
        checkupLocation()
        observe()
        observeCloseButton()
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func checkupLocation() {
        let address = adressStorage.fetchLastAddress()
        if address.isEmpty {
            showCurrentLocationOnMap()
        } else {
            showAddressOnMap(address)
        }
    }
}

//MARK: - Observe Logic
extension MapVC {
    func observe() {
        addressPanelView.onAddressChanged = { [weak self] addressText in
            guard let self else { return }
            self.showAddressOnMap(addressText)
        }
    }
    
    func observeCloseButton() {
        addressPanelView.onAddressChanged = { [weak self] addressText in
            guard let self else { return }
            self.onAddressSelected?(addressText)
            dismiss(animated: true)
        }
    }
}

//MARK: - Keyboard
extension MapVC {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        addressPanelView.addressView.addressTextField.endEditing(true)
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UITextField.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UITextField.keyboardDidHideNotification, object: nil)
        
        self.bottomConstraint = addressPanelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        self.bottomConstraint?.isActive = true
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        self.keyboardFrame = (notification.userInfo?[UITextField.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        self.bottomConstraint?.constant = -self.keyboardFrame.height
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.keyboardFrame = .zero
        self.bottomConstraint?.constant = 0
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}

//MARK: - Business Logic
extension MapVC {
    
    func fetchAddressFromLocation(_ location: CLLocation, completion: @escaping (String) -> Void) {
        self.geocodeService.fetchAddressFromLocation(location) { addressText in
            completion(addressText)
        }
    }
    
    func showAddressOnMap(_ addressText: String) {
        geocodeService.fetchLocationFromAddress(addressText) { [weak self] location in
            guard let self else { return }
            self.showLocationOnMap(location)
        }
    }
    
    func showCurrentLocationOnMap() {
        locationService.fetchCurrentLocation { [weak self] location in
            guard let self else { return }
            showLocationOnMap(location)
            fetchAddressFromLocation(location) { [weak self] addressText in
                self?.addressPanelView.update(addressText)
            }
        }
    }
    
    func showLocationOnMap(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 500.0
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
}

//MARK: - Layout
extension MapVC {
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        view.addSubview(pinImageView)
        view.addSubview(addressPanelView)
        view.addSubview(closeButton)
    }
    
    func setupConstraints() {
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        mapView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(addressPanelView.snp.top)
        }
        pinImageView.snp.makeConstraints { make in
            make.center.equalTo(mapView)
        }
        addressPanelView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK: - MKMapViewDelegate
extension MapVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        fetchAddressFromLocation(location) { addressText in
            self.addressPanelView.update(addressText)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        _ = mapView.centerCoordinate
    }
}
