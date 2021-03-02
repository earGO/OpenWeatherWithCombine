//
//  WeatherWithCombineApp.swift
//  WeatherWithCombine
//
//  Created by Edwin Odesseiron on 3/1/21.
//

import SwiftUI

@main
struct WeatherWithCombineApp: App {
	
	private let diContainer = DIContainer();
	private let viewModel = WeeklyWeatherViewModel();
	
    var body: some Scene {
        WindowGroup {
		WeeklyWeatherView(viewModel:viewModel);
        }
    }
}
