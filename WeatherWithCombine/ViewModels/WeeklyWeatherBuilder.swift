import SwiftUI

//this will act as a factory that creates the screen for navigation
enum WeeklyWeatherBuilder {
	static func makeCurrentWeatherView(
		withCity city: String
	) -> some View {
		let viewModel = CurrentWeatherViewModel(
			city: city)
		return CurrentWeatherView(viewModel: viewModel)
	}
}
