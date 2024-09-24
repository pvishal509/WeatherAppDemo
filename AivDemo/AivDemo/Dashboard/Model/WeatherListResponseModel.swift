//
//  WeatherListResponseModel.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import Foundation

struct WeatherListResponseModel: Decodable {

	let location: LocationModel?
	let forecast: ForecastModel?

	private enum CodingKeys: CodingKey {
		case location
		case forecast
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: WeatherListResponseModel.CodingKeys.self)

		self.location = try? container?.decodeIfPresent(LocationModel.self, forKey: WeatherListResponseModel.CodingKeys.location)
		self.forecast = try? container?.decodeIfPresent(ForecastModel.self, forKey: WeatherListResponseModel.CodingKeys.forecast)

	}
	internal init(location: LocationModel? = nil, forecast: ForecastModel? = nil) {
		self.location = location
		self.forecast = forecast
	}
}

// MARK: - Forecast
struct ForecastModel: Decodable {

	let forecastday: [Forecastday]?

	private enum CodingKeys: CodingKey {
		case forecastday
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: ForecastModel.CodingKeys.self)

		self.forecastday = try? container?.decodeIfPresent([Forecastday].self, forKey: ForecastModel.CodingKeys.forecastday)

	}
	internal init(forecastday: [Forecastday]? = nil) {
		self.forecastday = forecastday
	}

}

// MARK: - Forecastday
struct Forecastday: Decodable {
	let date: String?
	let dateEpoch: Int?
	let day: DayModel?
	let astro: Astro?
	let hour: [HourModel]?

	enum CodingKeys: String, CodingKey {
		case date
		case dateEpoch = "date_epoch"
		case day, astro, hour
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: Forecastday.CodingKeys.self)

		self.date = try? container?.decodeIfPresent(String.self, forKey: Forecastday.CodingKeys.date)
		self.dateEpoch = try? container?.decodeIfPresent(Int.self, forKey: Forecastday.CodingKeys.dateEpoch)
		self.day = try? container?.decodeIfPresent(DayModel.self, forKey: Forecastday.CodingKeys.day)
		self.astro = try? container?.decodeIfPresent(Astro.self, forKey: Forecastday.CodingKeys.astro)
		self.hour = try? container?.decodeIfPresent([HourModel].self, forKey: Forecastday.CodingKeys.hour)

	}
	internal init(date: String? = nil, dateEpoch: Int? = nil, day: DayModel? = nil, astro: Astro? = nil, hour: [HourModel]? = nil) {
		self.date = date
		self.dateEpoch = dateEpoch
		self.day = day
		self.astro = astro
		self.hour = hour
	}
}

// MARK: - Astro
struct Astro: Decodable {

	let sunrise, sunset, moonrise, moonset: String?
	let moonPhase: String?
	let moonIllumination: Int?

	enum CodingKeys: String, CodingKey {
		case sunrise, sunset, moonrise, moonset
		case moonPhase = "moon_phase"
		case moonIllumination = "moon_illumination"
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: Astro.CodingKeys.self)

		self.sunrise = try? container?.decodeIfPresent(String.self, forKey: Astro.CodingKeys.sunrise)
		self.sunset = try? container?.decodeIfPresent(String.self, forKey: Astro.CodingKeys.sunset)
		self.moonrise = try? container?.decodeIfPresent(String.self, forKey: Astro.CodingKeys.moonrise)
		self.moonset = try? container?.decodeIfPresent(String.self, forKey: Astro.CodingKeys.moonset)
		self.moonPhase = try? container?.decodeIfPresent(String.self, forKey: Astro.CodingKeys.moonPhase)
		self.moonIllumination = try? container?.decodeIfPresent(Int.self, forKey: Astro.CodingKeys.moonIllumination)

	}
	internal init(sunrise: String? = nil, sunset: String? = nil, moonrise: String? = nil, moonset: String? = nil, moonPhase: String? = nil, moonIllumination: Int? = nil) {
		self.sunrise = sunrise
		self.sunset = sunset
		self.moonrise = moonrise
		self.moonset = moonset
		self.moonPhase = moonPhase
		self.moonIllumination = moonIllumination
	}
}

// MARK: - Day
struct DayModel: Decodable {

	let maxtempC, maxtempF, mintempC: Double?
	let mintempF: Double?
	let avgtempC, avgtempF, maxwindMph, maxwindKph: Double?
	let totalprecipMm: Double?
	let totalprecipIn, totalsnowCM: Int?
	let avgvisKM: Double?
	let avgvisMiles, avghumidity, dailyWillItRain, dailyChanceOfRain: Int?
	let dailyWillItSnow, dailyChanceOfSnow: Int?
	let condition: Condition?
	let uv: Int?

	enum CodingKeys: String, CodingKey {
		case maxtempC = "maxtemp_c"
		case maxtempF = "maxtemp_f"
		case mintempC = "mintemp_c"
		case mintempF = "mintemp_f"
		case avgtempC = "avgtemp_c"
		case avgtempF = "avgtemp_f"
		case maxwindMph = "maxwind_mph"
		case maxwindKph = "maxwind_kph"
		case totalprecipMm = "totalprecip_mm"
		case totalprecipIn = "totalprecip_in"
		case totalsnowCM = "totalsnow_cm"
		case avgvisKM = "avgvis_km"
		case avgvisMiles = "avgvis_miles"
		case avghumidity
		case dailyWillItRain = "daily_will_it_rain"
		case dailyChanceOfRain = "daily_chance_of_rain"
		case dailyWillItSnow = "daily_will_it_snow"
		case dailyChanceOfSnow = "daily_chance_of_snow"
		case condition, uv
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: DayModel.CodingKeys.self)

		self.maxtempC = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.maxtempC)
		self.maxtempF = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.maxtempF)
		self.mintempC = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.mintempC)
		self.mintempF = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.mintempF)
		self.avgtempC = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.avgtempC)
		self.avgtempF = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.avgtempF)
		self.maxwindMph = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.maxwindMph)
		self.maxwindKph = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.maxwindKph)
		self.totalprecipMm = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.totalprecipMm)
		self.totalprecipIn = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.totalprecipIn)
		self.totalsnowCM = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.totalsnowCM)
		self.avgvisKM = try? container?.decodeIfPresent(Double.self, forKey: DayModel.CodingKeys.avgvisKM)
		self.avgvisMiles = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.avgvisMiles)
		self.avghumidity = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.avghumidity)
		self.dailyWillItRain = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.dailyWillItRain)
		self.dailyChanceOfRain = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.dailyChanceOfRain)
		self.dailyWillItSnow = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.dailyWillItSnow)
		self.dailyChanceOfSnow = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.dailyChanceOfSnow)
		self.condition = try? container?.decodeIfPresent(Condition.self, forKey: DayModel.CodingKeys.condition)
		self.uv = try? container?.decodeIfPresent(Int.self, forKey: DayModel.CodingKeys.uv)

	}
	internal init(maxtempC: Double? = nil, maxtempF: Double? = nil, mintempC: Double? = nil, mintempF: Double? = nil, avgtempC: Double? = nil, avgtempF: Double? = nil, maxwindMph: Double? = nil, maxwindKph: Double? = nil, totalprecipMm: Double? = nil, totalprecipIn: Int? = nil, totalsnowCM: Int? = nil, avgvisKM: Double? = nil, avgvisMiles: Int? = nil, avghumidity: Int? = nil, dailyWillItRain: Int? = nil, dailyChanceOfRain: Int? = nil, dailyWillItSnow: Int? = nil, dailyChanceOfSnow: Int? = nil, condition: Condition? = nil, uv: Int? = nil) {
		self.maxtempC = maxtempC
		self.maxtempF = maxtempF
		self.mintempC = mintempC
		self.mintempF = mintempF
		self.avgtempC = avgtempC
		self.avgtempF = avgtempF
		self.maxwindMph = maxwindMph
		self.maxwindKph = maxwindKph
		self.totalprecipMm = totalprecipMm
		self.totalprecipIn = totalprecipIn
		self.totalsnowCM = totalsnowCM
		self.avgvisKM = avgvisKM
		self.avgvisMiles = avgvisMiles
		self.avghumidity = avghumidity
		self.dailyWillItRain = dailyWillItRain
		self.dailyChanceOfRain = dailyChanceOfRain
		self.dailyWillItSnow = dailyWillItSnow
		self.dailyChanceOfSnow = dailyChanceOfSnow
		self.condition = condition
		self.uv = uv
	}
}

// MARK: - Condition
struct Condition: Decodable {

	let text, icon: String?
	let code: Int?

	private enum CodingKeys: CodingKey {
		case text
		case icon
		case code
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: Condition.CodingKeys.self)

		self.text = try? container?.decodeIfPresent(String.self, forKey: Condition.CodingKeys.text)
		self.icon = try? container?.decodeIfPresent(String.self, forKey: Condition.CodingKeys.icon)
		self.code = try? container?.decodeIfPresent(Int.self, forKey: Condition.CodingKeys.code)

	}
	internal init(text: String? = nil, icon: String? = nil, code: Int? = nil) {
		self.text = text
		self.icon = icon
		self.code = code
	}
}

// MARK: - Hour
struct HourModel: Decodable {
	let timeEpoch: Int?
	let time: String?
	let tempC, tempF: Double?
	let isDay: Int?
	let condition: Condition?
	let windMph, windKph: Double?
	let windDegree: Int?
	let windDir: WindDir?
	let pressureMB: Int?
	let pressureIn, precipMm: Double?
	let precipIn, snowCM, humidity, cloud: Int?
	let feelslikeC, feelslikeF, windchillC, windchillF: Double?
	let heatindexC, heatindexF, dewpointC, dewpointF: Double?
	let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int?
	let visKM, visMiles: Int?
	let gustMph, gustKph: Double?
	let uv: Int?

	enum CodingKeys: String, CodingKey {
		case timeEpoch = "time_epoch"
		case time
		case tempC = "temp_c"
		case tempF = "temp_f"
		case isDay = "is_day"
		case condition
		case windMph = "wind_mph"
		case windKph = "wind_kph"
		case windDegree = "wind_degree"
		case windDir = "wind_dir"
		case pressureMB = "pressure_mb"
		case pressureIn = "pressure_in"
		case precipMm = "precip_mm"
		case precipIn = "precip_in"
		case snowCM = "snow_cm"
		case humidity, cloud
		case feelslikeC = "feelslike_c"
		case feelslikeF = "feelslike_f"
		case windchillC = "windchill_c"
		case windchillF = "windchill_f"
		case heatindexC = "heatindex_c"
		case heatindexF = "heatindex_f"
		case dewpointC = "dewpoint_c"
		case dewpointF = "dewpoint_f"
		case willItRain = "will_it_rain"
		case chanceOfRain = "chance_of_rain"
		case willItSnow = "will_it_snow"
		case chanceOfSnow = "chance_of_snow"
		case visKM = "vis_km"
		case visMiles = "vis_miles"
		case gustMph = "gust_mph"
		case gustKph = "gust_kph"
		case uv
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: HourModel.CodingKeys.self)

		self.timeEpoch = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.timeEpoch)
		self.time = try? container?.decodeIfPresent(String.self, forKey: HourModel.CodingKeys.time)
		self.tempC = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.tempC)
		self.tempF = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.tempF)
		self.isDay = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.isDay)
		self.condition = try? container?.decodeIfPresent(Condition.self, forKey: HourModel.CodingKeys.condition)
		self.windMph = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.windMph)
		self.windKph = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.windKph)
		self.windDegree = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.windDegree)
		self.windDir = try? container?.decodeIfPresent(WindDir.self, forKey: HourModel.CodingKeys.windDir)
		self.pressureMB = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.pressureMB)
		self.pressureIn = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.pressureIn)
		self.precipMm = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.precipMm)
		self.precipIn = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.precipIn)
		self.snowCM = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.snowCM)
		self.humidity = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.humidity)
		self.cloud = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.cloud)
		self.feelslikeC = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.feelslikeC)
		self.feelslikeF = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.feelslikeF)
		self.windchillC = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.windchillC)
		self.windchillF = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.windchillF)
		self.heatindexC = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.heatindexC)
		self.heatindexF = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.heatindexF)
		self.dewpointC = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.dewpointC)
		self.dewpointF = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.dewpointF)
		self.willItRain = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.willItRain)
		self.chanceOfRain = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.chanceOfRain)
		self.willItSnow = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.willItSnow)
		self.chanceOfSnow = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.chanceOfSnow)
		self.visKM = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.visKM)
		self.visMiles = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.visMiles)
		self.gustMph = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.gustMph)
		self.gustKph = try? container?.decodeIfPresent(Double.self, forKey: HourModel.CodingKeys.gustKph)
		self.uv = try? container?.decodeIfPresent(Int.self, forKey: HourModel.CodingKeys.uv)

	}
}

enum WindDir: String, Decodable {
	case e = "E"
	case ene = "ENE"
	case ne = "NE"
	case nne = "NNE"
}
