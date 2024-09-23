//
//  SearchBar.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import Foundation
import SwiftUI

public struct SearchBar: View {

	@Binding var searchText: String
	@Binding var isSearchEnable: Bool

	var backgrounColor: Color = .gray
	var completionTextChange: ((_ text: String)->())
	var completionDone: (()->())?

	public init(searchText: Binding<String> , isSearchEnable: Binding<Bool>, backgrounColor: SwiftUI.Color = .gray.opacity(0.3), completionTextChange: @escaping (_: String) -> Void, completionDone: (()->())?) {
		self._searchText = searchText
		self._isSearchEnable = isSearchEnable
		self.backgrounColor = backgrounColor
		self.completionTextChange = completionTextChange
		self.completionDone = completionDone
	}

	public var body: some View {
		searchView
	}
}

extension SearchBar {

	private var searchView: some View {

		HStack(spacing: 20) {

			HStack(spacing: 10) {
				Image(systemName: "magnifyingglass").foregroundColor(Color.Neumorphic.secondary).font(Font.body.weight(.bold))

				TextField("Search", text: $searchText)
					.font(.title3.bold())
					.foregroundColor(Color.Neumorphic.secondary)
					.onChange(of: searchText) { newValue in
						isSearchEnable = !(newValue.isEmpty)
						completionTextChange(newValue)
					}

				if isSearchEnable {
					Button {
						searchCancel()
						self.endEditing(true)
					} label: {
						Image("ic_close")
							.resizable()
							.scaledToFit()
							.foregroundColor(.gray)
							.frame(width: 10, height: 10)
					}
					.frame(width: 24, height: 24)
				}
			}
			.frame(idealHeight: 36, maxHeight: 36)
            .padding(.vertical, 8)
			.padding(.horizontal, 18)
			.background(
				RoundedRectangle(cornerRadius: 15).fill(Color.Neumorphic.main).softInnerShadow(RoundedRectangle(cornerRadius: 15))
			)
			
			Button(action: {
				self.endEditing(true)
				completionDone?()
			}) {
				Text("Done")
					.fontWeight(.bold)
			}.softButtonStyle(RoundedRectangle(cornerRadius: 8))

		}
	}

	private func searchCancel() {
		self.searchText = ""
		isSearchEnable = false
	}

}

struct SearchBar_Previews: PreviewProvider {
	static var previews: some View {

		SearchBar(searchText: .constant(""), isSearchEnable: .constant(false)) { str in

		} completionDone: {

		}
	}
}

extension View {
  public func endEditing(_ force: Bool, completion: (()->())? = nil) {
	UIApplication.shared.windows.forEach { $0.endEditing(force)}
	DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
	  completion?()
	})
  }
}
