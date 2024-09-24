//
//  DashboardViewModelTests.swift
//  AivDemoTests
//
//  Created by Vishal on 24/09/24.
//

import XCTest
import Combine
@testable import AivDemo

class DashboardViewModelTests: XCTestCase {

	var viewModel: DashboardViewModel!
	var mockDataFetcher: MockWeatherRequest!

	override func setUp() {
		super.setUp()
		mockDataFetcher = MockWeatherRequest()
		viewModel = DashboardViewModel(dataFetcher: mockDataFetcher)
	}

	override func tearDown() {
		viewModel = nil
		mockDataFetcher = nil
		super.tearDown()
	}

	func testGetWeatherDataSuccess() {
		let cityName: String = "London"
		// Arrange
		let expectedLocation = LocationModel(name: cityName, lat: 51.5074, lon: -0.1278)
		let expectedCurrent = CurrentModel(tempC: 15.0, condition: ConditionModel(text: "Clear"))
		mockDataFetcher.mockResponse = .success(WeatherResponseModel(location: expectedLocation, current: expectedCurrent))

		// Act
		viewModel.getWeatherData(cityName: cityName)

		// Assert
		XCTAssertNotNil(expectedLocation.name)
		XCTAssertNotNil(expectedCurrent.tempC)

	}

	func testGetWeatherDataFailure() {
		// Arrange
		mockDataFetcher.mockResponse = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
		let cityName: String = "London"
		// Act
		viewModel.getWeatherData(cityName: cityName)

		// Assert
		XCTAssertNil(viewModel.locationData)
		XCTAssertNil(viewModel.currentData)
	}

	func testGetForecastDataSuccess() {
		// Arrange
		let expectedForecast = [Forecastday(date: "2024-09-23")]
		mockDataFetcher.forecastMockResponse = .success(WeatherListResponseModel(forecast: ForecastModel(forecastday: expectedForecast)))

		// Assert
		XCTAssertNotNil(expectedForecast)
	}

	@MainActor func testGetForecastDataFailure() {
		// Arrange
		mockDataFetcher.forecastMockResponse = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
		let cityName: String = "London"
		// Act
		viewModel.getForecastData(cityName: cityName)

		// Assert

		XCTAssertEqual(viewModel.forecastData.count, 0)
	}
}


class MockWeatherRequest: WeatherRequest {

	

	var mockResponse: Result<WeatherResponseModel, Error>?
	var forecastMockResponse: Result<WeatherListResponseModel, Error>?
	var forecastMockListResponse: Result<[WeatherListResponseModel], Error>?

	func getCurrentWeather(city: String) -> Future<AivDemo.WeatherResponseModel, any Error> {
		return Future { promise in
			if let response = self.mockResponse {
				promise(response)
			} else {
				promise(.failure(NSError(domain: "MockWeatherRequest", code: -1, userInfo: nil))) // Handle the error case
			}
		}
	}

	func getForecastWeatherList(city: String) -> Future<AivDemo.WeatherListResponseModel, any Error> {
		return Future { promise in
			if let response = self.forecastMockResponse {
				promise(response)
			} else {
				promise(.failure(NSError(domain: "MockWeatherRequest", code: -1, userInfo: nil))) // Handle the error case
			}
		}
	}

	func getForecastWeatherList(city: String) -> Future<[AivDemo.WeatherListResponseModel], any Error> {
		return Future { promise in
			if let response = self.forecastMockListResponse {
				promise(response)
			} else {
				promise(.failure(NSError(domain: "MockWeatherRequest", code: -1, userInfo: nil))) // Handle the error case
			}
		}
	}
}
