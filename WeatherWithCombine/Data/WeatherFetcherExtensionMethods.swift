//
//  WeatherFetcherExtensionMethods.swift
//  WeatherWithCombine
//
//  Created by Edwin Odesseiron on 3/1/21.
//

import Foundation
import Combine

//MARK: - forecast function that sends the requests to the Open Weather Api
extension WeatherFetcher {
    /* this is what fetches the data using the session and provided request components
      it returns a Publisher with either the type or error */
    func forecast<T>(_ session: URLSession, with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
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
                /* erases whatever actual type there will be to a simple AnyPublisher
                 useful when we decide to add some transformations to the data */
                .eraseToAnyPublisher()
    }

}

//MARK: - request Component creators for the forecast function
extension WeatherFetcher{
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
