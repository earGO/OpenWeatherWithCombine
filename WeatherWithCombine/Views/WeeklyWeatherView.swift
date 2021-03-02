//
//  WeeklyWeatherView.swift
//  WeatherWithCombine
//
//  Created by Edwin Odesseiron on 3/1/21.
//

import SwiftUI

struct WeeklyWeatherView: View {
	@ObservedObject var viewModel: WeeklyWeatherViewModel
	
	init(viewModel: WeeklyWeatherViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		NavigationView {
			List {
				searchField
				
				if viewModel.dataSource.isEmpty {
					emptySection
				} else {
					cityHourlyWeatherSection
					forecastSection
				}
			}
			.listStyle(GroupedListStyle())
			.navigationBarTitle("Weather ⛅️")
		}
	}
}

struct WeeklyWeatherView_Previews: PreviewProvider {
	
    static var previews: some View {
	let viewModel = WeeklyWeatherViewModel();
        WeeklyWeatherView(viewModel: viewModel)
    }
}

private extension WeeklyWeatherView {
	var searchField: some View {
		HStack(alignment: .center) {
			// 1
			TextField("e.g. Cupertino", text: $viewModel.city)
		}
	}
	
	var forecastSection: some View {
		Section {
			// 2
			ForEach(viewModel.dataSource, content: DailyWeatherRow.init(viewModel:))
		}
	}
	
	var cityHourlyWeatherSection: some View {
		Section {
			NavigationLink(destination: CurrentWeatherView()) {
				VStack(alignment: .leading) {
					// 3
					Text(viewModel.city)
					Text("Weather today")
						.font(.caption)
						.foregroundColor(.gray)
				}
			}
		}
	}
	
	var emptySection: some View {
		Section {
			Text("No results")
				.foregroundColor(.gray)
		}
	}
}
