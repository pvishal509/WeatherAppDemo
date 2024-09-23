//
//  WeatherManager.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import SwiftUI
import Foundation
import Combine

class WeatherManager: WeatherRequest {

	private var currentWeatherCache: [String: WeatherResponseModel] = [:]
	private var forecastWeatherCache: [String: [WeatherListResponseModel]] = [:]


	func getCurrentWeather(city: String) -> Future<WeatherResponseModel, Error> {
		return Future { promise in
			// Check cache first
			if let cachedWeather = self.currentWeatherCache[city] {
				promise(.success(cachedWeather))
				return
			}

			// Create the URL
			guard let url = URL(string: "\(Constants.baseURL)/current.json?key=\(Constants.apiKey)&q=\(city)&aqi=no") else {
				promise(.failure(NSError(domain: "WeatheryManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing URL"])))
				return
			}

			// Create the URLRequest
			let urlRequest = URLRequest(url: url)

			// Use URLSession to fetch data
			URLSession.shared.dataTask(with: urlRequest) { data, response, error in
				if let error = error {
					promise(.failure(error))
					return
				}

				guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
					let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
					promise(.failure(NSError(domain: "WeatheryManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error fetching weather data, status code: \(statusCode)"])))
					return
				}

				// Decode the JSON data
				if let data = data {
					do {
						let decodedData = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
						// Store the result in the cache
						self.currentWeatherCache[city] = decodedData
						promise(.success(decodedData))
					} catch let decodingError {
						promise(.failure(decodingError))
					}
				} else {
					promise(.failure(NSError(domain: "WeatheryManager", code: 3, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
				}
			}.resume()
		}
	}

	func getForecastWeatherList(city: String) -> Future<[WeatherListResponseModel], Error> {
		return Future { promise in
			// Check cache first
			if let cachedForecast = self.forecastWeatherCache[city] {
				promise(.success(cachedForecast))
				return
			}

			// Create a dispatch group to wait for all requests to complete
			let dispatchGroup = DispatchGroup()
			var results: [WeatherListResponseModel] = []
			var errors: [Error] = []
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"

			// Loop to get data for the last 5 days
			for daysAgo in 0..<5 {
				// Calculate the date
				guard let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) else { continue }
				let formattedDate = dateFormatter.string(from: date)

				// Create the URL
				guard let url = URL(string: "\(Constants.baseURL)/history.json?key=\(Constants.apiKey)&q=\(city)&dt=\(formattedDate)") else {
					promise(.failure(NSError(domain: "WeatheryManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing URL for date \(formattedDate)"])))
					return
				}

				// Enter the dispatch group
				dispatchGroup.enter()

				// Create the URLRequest
				let urlRequest = URLRequest(url: url)

				// Use URLSession to fetch data
				URLSession.shared.dataTask(with: urlRequest) { data, response, error in
					defer { dispatchGroup.leave() } // Leave the group on completion

					if let error = error {
						errors.append(error) // Collect errors for reporting later
						return
					}

					guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
						let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
						errors.append(NSError(domain: "WeatheryManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error fetching weather data, status code: \(statusCode)"]))
						return
					}

					// Decode the JSON data
					if let data = data {
						do {
							let decodedData = try JSONDecoder().decode(WeatherListResponseModel.self, from: data)
							results.append(decodedData) // Append the result for each date
						} catch let decodingError {
							errors.append(decodingError) // Collect decoding errors
						}
					} else {
						errors.append(NSError(domain: "WeatheryManager", code: 3, userInfo: [NSLocalizedDescriptionKey: "No data received for date \(formattedDate)"]))
					}
				}.resume()
			}

			// Notify when all requests are complete
			dispatchGroup.notify(queue: .main) {
				if errors.isEmpty {
					self.forecastWeatherCache[city] = results // Cache the results
					promise(.success(results)) // Return all results if there are no errors
				} else {
					// Return the first error found if any
					promise(.failure(errors.first!))
				}
			}
		}
	}

}

