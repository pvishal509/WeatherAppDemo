//
//  DashboardViewModel.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import Foundation
import Combine
import Foundation

final class DashboardViewModel: ObservableObject {

	@Published var locationData: LocationModel? = nil
	@Published var currentData: CurrentModel? = nil
	@Published var forecastData: [Forecastday] = []
	@Published var searchText: String = ""

	var dataFetcher: WeatherRequest

	var cancellables: Set<AnyCancellable> = []

	init(dataFetcher: WeatherRequest = WeatherManager()) {
		self.dataFetcher = dataFetcher
	}

}
// MARK: - API Calling
extension DashboardViewModel {

	func getWeatherData(cityName: String) {
		dataFetcher.getCurrentWeather(city: cityName)
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print(error.localizedDescription)
				}
			} receiveValue: { [weak self] resonse in
				DispatchQueue.main.async {
					self?.locationData = resonse.location
					self?.currentData = resonse.current
					print(resonse)
				}
			}.store(in: &cancellables)

	}

	@MainActor
	func getForecastData(cityName: String) {
		dataFetcher.getForecastWeatherList(city: cityName)
			.sink { completion in
				switch completion {
				case .finished:
					break
				case .failure(let error):
					print(error.localizedDescription)
				}
			} receiveValue: { [weak self] response in
				let arr = response.compactMap { $0.forecast?.forecastday }
					.flatMap { $0 }
				self?.forecastData = arr.sorted { $0.date ?? "" > $1.date ?? "" }
			}
			.store(in: &cancellables)
	}

}
