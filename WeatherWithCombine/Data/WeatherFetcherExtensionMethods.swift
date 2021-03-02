//
//  WeatherFetcherExtensionMethods.swift
//  WeatherWithCombine
//
//  Created by Edwin Odesseiron on 3/1/21.
//

import Foundation
import Combine

extension WeatherFetcher {
	func forecast<T>(_ session: URLSession, with components: URLComponents)->AnyPublisher<T, WeatherError> where T:Decodable {
		guard let url = components.url else {
			let error = WeatherError.network(description: "Couldn't create URL")
			return Fail(error: error).eraseToAnyPublisher()
		}
		
		return session.dataTaskPublisher(for: URLRequest(url: url))
			
			.mapError { error in
				.network(description: error.localizedDescription)
			}
			
			.flatMap(maxPublishers: .max(1)) { pair in
				decode(pair.data)
			}
			
			.eraseToAnyPublisher()
	}
	

	func makeWeeklyForecastComponents(
		withCity city: String
	) -> URLComponents {
		var components = URLComponents()
		components.scheme = OpenWeatherApiConfig.scheme
		components.host = OpenWeatherApiConfig.host
		components.path = OpenWeatherApiConfig.path + "/forecast"
		
		components.queryItems = [
			URLQueryItem(name: "q", value: city),
			URLQueryItem(name: "mode", value: "json"),
			URLQueryItem(name: "units", value: "metric"),
			URLQueryItem(name: "APPID", value: OpenWeatherApiConfig.key)
		]
		
		return components
	}
	
	func makeCurrentDayForecastComponents(
		withCity city: String
	) -> URLComponents {
		var components = URLComponents()
		components.scheme = OpenWeatherApiConfig.scheme
		components.host = OpenWeatherApiConfig.host
		components.path = OpenWeatherApiConfig.path + "/weather"
		
		components.queryItems = [
			URLQueryItem(name: "q", value: city),
			URLQueryItem(name: "mode", value: "json"),
			URLQueryItem(name: "units", value: "metric"),
			URLQueryItem(name: "APPID", value: OpenWeatherApiConfig.key)
		]
		
		return components
	}
}
