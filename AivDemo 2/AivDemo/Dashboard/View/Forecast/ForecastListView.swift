//
//  ForecastListView.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import SwiftUI

struct ForecastListView: View {

	var forecastData: [Forecastday]

    var body: some View {
		setForecastView
    }

	var setForecastView: some View {
		VStack {
			Text("Forecast")
				.frame(maxWidth: .infinity, alignment: .leading)
				.bold()

			setForecardListView
		}
		.padding()
	}

	var setForecardListView: some View {
		LazyVStack(spacing: 12) {
			ForEach(forecastData, id: \.date) { obj in
				ForecastCellView(obj: obj)
			}
		}
	}
}

#Preview {
	ForecastListView(forecastData: [])
}
