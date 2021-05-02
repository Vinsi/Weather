//
//  LocationServiceManager.swift
//

import CoreLocation
import RxSwift

final class LocationServiceManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationServiceManager()
    let locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var city = BehaviorSubject<String?>(value: nil)
    var country: String?
    var countryIsoCode: String?
    var localStreet: String?
    
    var onLocationUpdate: ((CLPlacemark) -> ())?
    var onLocationPermissionDenied: (() -> ())?
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
    }
    
    var isLocationServiceEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    var isLocationAuthorizationStatusEnabled: Bool {
        if #available(iOS 14, *) {
            switch locationManager?.authorizationStatus {
            case .restricted,.denied:
                return false
            default:
                return true
            }
        } else {
            return CLLocationManager.authorizationStatus() == .authorizedWhenInUse ? true: false
        }
    }
    
    func requestLocationServiceWhenInUse() {
        switch locationManager?.authorizationStatus {
        case .some(.denied), .some(.restricted):
            onLocationPermissionDenied?()
        case .some(.authorizedAlways), .some(.authorizedWhenInUse), .some(.notDetermined):
            locationManager?.requestAlwaysAuthorization()
        case .none:
            break
        @unknown default:
            break
        }
    }
    
    func reverseGeocode(location: CLLocation) {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { [weak self] (placemarks, error) -> Void in
            
            guard let self = self else {
                return
            }
            
            guard error == nil else {
                self.onLocationPermissionDenied?()
                return
            }
            if let placemarks = placemarks, let currentPlacemark = placemarks.first {
                self.city.onNext(currentPlacemark.locality?.lowercased())
                self.localStreet = currentPlacemark.name?.lowercased()
                self.country = currentPlacemark.country?.lowercased()
                self.countryIsoCode = currentPlacemark.isoCountryCode?.lowercased()
                self.onLocationUpdate?(currentPlacemark)
            }
        })
    }
    
    func setup() {
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        requestLocationServiceWhenInUse()
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            currentLocation = locations.first
            if let location = currentLocation {
                reverseGeocode(location: location)
                locationManager?.stopUpdatingLocation()
            }
        } else {
            onLocationPermissionDenied?()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if let location = currentLocation {
                reverseGeocode(location: location)
            } else {
                locationManager?.startUpdatingLocation()
            }
        default:
            onLocationPermissionDenied?()
        }
    }
}

