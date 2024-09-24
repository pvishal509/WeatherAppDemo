//
//  WeatherDetailView.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import SwiftUI

struct WeatherDetailView: View {

	var currentData: CurrentModel?

    var body: some View {
		setDetailView
    }

	var setDetailView: some View {
		HStack(spacing: 16) {
			gridComanView(title: "Humidity", subTitle: "\(currentData?.humidity ?? 0) %" )
			gridComanView(title: "wind speed", subTitle: "\(currentData?.windKph ?? 0) kph")
			gridComanView(title: "Direction", subTitle: currentData?.windDir ?? "NA")
		}
		.padding(.horizontal)
	}

	func gridComanView(title: String, subTitle: String) -> some View {

		VStack(spacing: 8) {
			Text(title)
				.fontWeight(.bold)
				.frame(maxWidth: .infinity, alignment: .center)
			Text(subTitle)
				.frame(maxWidth: .infinity, alignment: .center)
		}
		.multilineTextAlignment(.center)
		.padding(.vertical)
		.background(
			RoundedRectangle(cornerRadius: 12).fill(Color.Neumorphic.main).softOuterShadow()
		)
	}
}

#Preview {
    WeatherDetailView()
}
