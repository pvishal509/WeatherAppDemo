//
//  LocationManager.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
	@Published var location: CLLocationCoordinate2D?
	@Published var cityName: String?
	@Published var isLoading = false

	@Published var locationManager = CLLocationManager()
	let geocoder = CLGeocoder()

	var completioUpdateLocation: (()->())?

	override init() {
		super.init()
		locationManager.delegate = self
	}

	func requestLocation() {
		isLoading = true
		locationManager.requestWhenInUseAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
		locationManager.requestLocation()
		locationManager.startUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		self.location = location.coordinate
		isLoading = false

		// Reverse geocode to get the city name
		reverseGeocode(location: location)
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		isLoading = false
		if let clError = error as? CLError {
			switch clError.code {
			case .locationUnknown:
				print("Error, location unknown", error)
			case .denied:
				print("Error, Location denied", error)
			default:
				print("Error getting location", error)
			}
		}
	}

	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		// Update the authorization status
		switch locationManager.authorizationStatus {
		case .notDetermined:
			print("Location access notDetermined")
		case .restricted:
			print("Location access restricted")
		case .denied:
			print("Location access denied")
		case .authorizedAlways, .authorizedWhenInUse, .authorized:
			requestLocation()
			completioUpdateLocation?()
		@unknown default:
			print("Location access @unknown")
		}
	}

	 func reverseGeocode(location: CLLocation) {
		geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
			if let error = error {
				print("Reverse geocode failed: \(error.localizedDescription)")
				return
			}
			if let placemark = placemarks?.first {
				self?.cityName = placemark.locality
			}
		}
	}
}
