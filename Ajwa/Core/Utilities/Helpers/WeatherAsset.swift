//
//  WeatherAsserts.swift
//  Ajwa
//
//  Created by Moaz on 10/06/2026.
//

import Foundation

enum WeatherAsset: String {
    case clearSunny = "clear-sunny"
    case clearNight = "clear-night"

    case partiallyCloudy = "partially-cloudy"
    case partiallyCloudyNight = "partially-cloudy-night"

    case cloudy = "cloudy"
    case haze = "haze"

    case rain = "rain"
    case heavyRain = "heavy-rain"

    case thunderstorm = "thunderstorm"
    case snow = "snow"

    case sandstorm = "sandstorm"
}

extension WeatherAsset {

    static func from(
        code: Int,
        isDay: Bool
    ) -> WeatherAsset {

        switch code {

        // Clear
        case 1000:
            return isDay ? .clearSunny : .clearNight

        // Partly Cloudy
        case 1003:
            return isDay
                ? .partiallyCloudy
                : .partiallyCloudyNight

        // Cloudy / Overcast
        case 1006, 1009:
            return .cloudy

        // Haze / Fog / Smoke
        case 1012, 1030, 1033, 1036,
             1039, 1042, 1135, 1147:
            return .haze

        // Sand / Dust
        case 1015, 1018, 1021,
             1024, 1027, 1045, 1048:
            return .sandstorm

        // Thunder
        case 1087,
             1273, 1276,
             1279, 1282:
            return .thunderstorm

        // Snow
        case 1066, 1114, 1117,
             1210, 1213, 1216,
             1219, 1222, 1225,
             1255, 1258:
            return .snow

        // Heavy Rain
        case 1192, 1195,
             1201,
             1243, 1246:
            return .heavyRain

        // Rain
        case 1063, 1072,
             1150, 1153,
             1168, 1171,
             1180, 1183,
             1186, 1189,
             1198,
             1204, 1207,
             1240, 1249,
             1252, 1261,
             1264, 1237:
            return .rain

        default:
            return .cloudy
        }
    }
}
