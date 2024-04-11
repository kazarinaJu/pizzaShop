//
//  GeocodeService.swift
//  dodo
//
//  Created by Юлия Ястребова on 30.03.2024.
//

import Foundation
import CoreLocation

class GeocodeService {
    
    var geoCoder = CLGeocoder()
    
    //Функция для получения местоположения из адреса
    func fetchLocationFromAddress(_ addressText: String, completion: @escaping (CLLocation) -> Void) {
        
        let addressString = addressText
        
        //гео?кодируем адрес
        geoCoder.geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else { //Получаем первый найденный местный объект
                print("No placemarks found")
                return
            }
            let location = placemark.location // Получаем координаты местоположения
            
            if let location = location {
                completion(location) //Вызываем замыкание с полученным местоположением
            }
        }
    }
    
    // Функция для получения адреса из местоположения
    func fetchAddressFromLocation(_ location: CLLocation, completion: @escaping (String) -> Void) {
        // Обратное гео?кодирование местоположения
        geoCoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ru_RU")) { placemarks, error in
            
            if let place = placemarks?.first {
                var address: [String] = []
                
                if let locality = place.locality { //населенный пункт
                    address += [locality]
                }
                
                if let thoroughfare = place.thoroughfare { //улица
                    address += [thoroughfare]
                }
                
                if let subThoroughfare = place.subThoroughfare { //дом
                    address += [subThoroughfare]
                }
                
                let result = address.joined(separator: ", ")
                completion(result)
            }
        }
    }
}

