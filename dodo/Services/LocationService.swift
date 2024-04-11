//
//  LocationService.swift
//  dodo
//
//  Created by Юлия Ястребова on 30.03.2024.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    var locationManager = CLLocationManager()
    var onLocationFetched: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchCurrentLocation(completion: @escaping (CLLocation) -> Void) {
        locationManager.startUpdatingLocation()
        onLocationFetched = completion
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined") //не запрошено
        case .restricted:
            //добавить alert что доступ запрещен и кнопка ок?
            print("Restricted by parental control") //ограничено на устройстве (напр, род контроль)
        case .denied:
            
            //добавить alert и отправить в настройки включать геопозицию?
            print("When user select option Dont't Allow") //запретил использование
        case .authorizedAlways:
            print("When user select option Allow While Using App or Allow O") //разрешать всегда использовать местоположение
        case .authorizedWhenInUse:
            //mapView.showsUserLocation = true
            print("When user select option Allow While Using App or Allow O") //разрешить при использовании приложения
        @unknown default:
            print("default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        locationManager.stopUpdatingLocation()
        onLocationFetched?(location)
    }
}
