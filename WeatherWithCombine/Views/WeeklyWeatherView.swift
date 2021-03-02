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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
