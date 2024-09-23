//
//  WeatherRequestModel.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import Foundation
import Combine

protocol WeatherRequest {
	func getCurrentWeather(city: String) -> Future<WeatherResponseModel, Error>
	func getForecastWeatherList(city: String) -> Future<[WeatherListResponseModel], Error>
}
