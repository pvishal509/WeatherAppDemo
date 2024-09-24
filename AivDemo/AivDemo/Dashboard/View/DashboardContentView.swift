//
//  DashboardContentView.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import SwiftUI

struct DashboardContentView: View {
	@StateObject var viewModel: DashboardViewModel = DashboardViewModel()
	@StateObject var locationManager = LocationManager()

	var body: some View {
		ZStack {
			Color.Neumorphic.main.ignoresSafeArea()

			VStack {
				ScrollView {
					if viewModel.currentData != nil  {
						VStack {
							setSearchView
							setTopView
							WeatherDetailView(currentData: viewModel.currentData)
							ForecastListView(forecastData: viewModel.forecastData)
						}
					} else {
						setSearchView
					}
				}
			}
		}
		.onAppear {
			locationManager.requestLocation()
			locationManager.completioUpdateLocation = {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					viewModel.getWeatherData(cityName: locationManager.cityName ?? "")
					viewModel.getForecastData(cityName: locationManager.cityName ?? "")
				}
			}
		}
	}

	var setSearchView: some View {
		SearchBar(searchText: $viewModel.searchText, isSearchEnable: .constant(false)) { str in

		} completionDone: {
			viewModel.getWeatherData(cityName: viewModel.searchText)
			viewModel.getForecastData(cityName: viewModel.searchText)
		}
		.padding()
	}

	var setTopView: some View {
		VStack(spacing: 0) {
			Text(viewModel.locationData?.name ?? "")
				.font(.subheadline)

			HStack(alignment: .top, spacing: 2) {
				Text("\(String(format: "%.1f", viewModel.currentData?.tempF ?? 0.0))")
					.font(.largeTitle.bold())

				Text("o")
					.font(.subheadline.bold())
			}
		}
	}
}

#Preview {
    DashboardContentView()
}


