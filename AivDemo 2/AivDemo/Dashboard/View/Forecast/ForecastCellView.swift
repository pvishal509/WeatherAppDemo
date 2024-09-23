//
//  ForecastCellView.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import SwiftUI

struct ForecastCellView: View {

	var obj: Forecastday?

	var body: some View {
		HStack {
			Text(obj?.date ?? "")

			Spacer()

			minMaxView(title: "Min", subTitle: obj?.day?.mintempF ?? 0.0)

			Spacer()

			minMaxView(title: "Max", subTitle: obj?.day?.maxtempF ?? 0.0)
		}
		.padding()
		.background(
			RoundedRectangle(cornerRadius: 8).fill(Color.Neumorphic.main).softOuterShadow()
		)
	}

	func minMaxView(title: String, subTitle: Double) -> some View {
		VStack {
			Text(title)
				.bold()

			Text("\(String(format: "%.1f", subTitle))")
		}
	}
}

#Preview {
	ForecastCellView(obj: nil)
}
