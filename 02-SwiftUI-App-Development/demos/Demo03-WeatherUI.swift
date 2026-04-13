// ============================================================
// Demo03-WeatherUI.swift
// A mock weather app UI showcasing complex layouts, gradients,
// SF Symbols, and animations. No real API calls -- all data
// is hardcoded for classroom demonstration.
//
// Concepts demonstrated:
//   - LinearGradient backgrounds
//   - SF Symbols for weather icons
//   - ScrollView, LazyVGrid, LazyHStack
//   - Custom shapes and overlays
//   - withAnimation and .animation modifiers
//   - @State to drive interactive elements
//   - GeometryReader basics
//   - Extracted subviews for clean architecture
//
// Requirements:
//   - iOS 17+ / Xcode 15+
//   - SwiftUI only (no UIKit)
//
// How to use:
//   1. Create a new Xcode project (App template, SwiftUI).
//   2. Replace ContentView.swift with this file.
//   3. Run on a simulator or preview canvas.
// ============================================================

import SwiftUI

// MARK: - Data Models
// Simple structs representing weather data. In a production app,
// these would be decoded from a JSON API response.

struct HourlyForecast: Identifiable {
    let id = UUID()
    var hour: String        // e.g. "3 PM"
    var temperature: Int    // Fahrenheit
    var symbolName: String  // SF Symbol name
}

struct DailyForecast: Identifiable {
    let id = UUID()
    var day: String         // e.g. "Monday"
    var high: Int
    var low: Int
    var symbolName: String
}

struct WeatherCondition {
    var cityName: String
    var currentTemp: Int
    var description: String
    var high: Int
    var low: Int
    var feelsLike: Int
    var humidity: Int
    var windSpeed: Int
    var uvIndex: Int
}

// MARK: - Sample Data

let sampleCondition = WeatherCondition(
    cityName: "San Francisco",
    currentTemp: 64,
    description: "Partly Cloudy",
    high: 68,
    low: 55,
    feelsLike: 62,
    humidity: 72,
    windSpeed: 14,
    uvIndex: 5
)

let sampleHourly: [HourlyForecast] = [
    HourlyForecast(hour: "Now",  temperature: 64, symbolName: "cloud.sun.fill"),
    HourlyForecast(hour: "1 PM", temperature: 65, symbolName: "cloud.sun.fill"),
    HourlyForecast(hour: "2 PM", temperature: 66, symbolName: "sun.max.fill"),
    HourlyForecast(hour: "3 PM", temperature: 68, symbolName: "sun.max.fill"),
    HourlyForecast(hour: "4 PM", temperature: 67, symbolName: "cloud.sun.fill"),
    HourlyForecast(hour: "5 PM", temperature: 65, symbolName: "cloud.fill"),
    HourlyForecast(hour: "6 PM", temperature: 63, symbolName: "cloud.fill"),
    HourlyForecast(hour: "7 PM", temperature: 60, symbolName: "cloud.moon.fill"),
    HourlyForecast(hour: "8 PM", temperature: 58, symbolName: "moon.stars.fill"),
]

let sampleDaily: [DailyForecast] = [
    DailyForecast(day: "Today",     high: 68, low: 55, symbolName: "cloud.sun.fill"),
    DailyForecast(day: "Tuesday",   high: 70, low: 56, symbolName: "sun.max.fill"),
    DailyForecast(day: "Wednesday", high: 65, low: 54, symbolName: "cloud.rain.fill"),
    DailyForecast(day: "Thursday",  high: 62, low: 52, symbolName: "cloud.heavyrain.fill"),
    DailyForecast(day: "Friday",    high: 66, low: 53, symbolName: "cloud.sun.fill"),
    DailyForecast(day: "Saturday",  high: 72, low: 57, symbolName: "sun.max.fill"),
    DailyForecast(day: "Sunday",    high: 71, low: 56, symbolName: "sun.max.fill"),
]

// MARK: - Main Weather View

struct WeatherView: View {
    let condition = sampleCondition
    let hourly = sampleHourly
    let daily = sampleDaily

    // State to drive a simple animation demo:
    // Tapping the temperature toggles between Fahrenheit and Celsius.
    @State private var showCelsius = false

    // Computed property to convert temperature
    var displayTemp: String {
        if showCelsius {
            let celsius = Int(round(Double(condition.currentTemp - 32) * 5.0 / 9.0))
            return "\(celsius)"
        } else {
            return "\(condition.currentTemp)"
        }
    }

    var body: some View {
        // ── Full-screen gradient background ──
        ZStack {
            // A gradient simulating a daytime sky.
            // Change these colors to simulate night, sunrise, etc.
            LinearGradient(
                colors: [
                    Color(red: 0.15, green: 0.35, blue: 0.65),  // Deep blue
                    Color(red: 0.45, green: 0.65, blue: 0.90),  // Sky blue
                    Color(red: 0.70, green: 0.82, blue: 0.95),  // Light blue
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()  // Fill the entire screen including safe areas

            // ── Scrollable content ──
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {

                    // ── City and Current Temperature ──
                    CurrentWeatherHeader(
                        condition: condition,
                        displayTemp: displayTemp,
                        showCelsius: showCelsius
                    ) {
                        // Toggle between F and C with an animation
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showCelsius.toggle()
                        }
                    }

                    // ── Hourly Forecast ──
                    HourlyForecastCard(hourly: hourly)

                    // ── 7-Day Forecast ──
                    DailyForecastCard(daily: daily)

                    // ── Detail Grid (Feels Like, Humidity, Wind, UV) ──
                    WeatherDetailGrid(condition: condition)

                    // ── Footer ──
                    Text("Data is hardcoded for demonstration purposes.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                        .padding(.bottom, 32)
                }
                .padding(.top, 40)
            }
        }
    }
}

// MARK: - Current Weather Header
// Displays the city name, temperature (tappable), and description.

struct CurrentWeatherHeader: View {
    let condition: WeatherCondition
    let displayTemp: String
    let showCelsius: Bool
    var onTapTemperature: () -> Void

    var body: some View {
        VStack(spacing: 4) {
            // City name
            Text(condition.cityName)
                .font(.system(size: 34, weight: .medium))
                .foregroundStyle(.white)

            // Large temperature display -- tap to toggle F/C
            Button(action: onTapTemperature) {
                HStack(alignment: .top, spacing: 2) {
                    Text(displayTemp)
                        .font(.system(size: 96, weight: .thin))
                        .foregroundStyle(.white)
                        // Content transition animates the number change
                        .contentTransition(.numericText())

                    Text(showCelsius ? "C" : "F")
                        .font(.system(size: 32, weight: .light))
                        .foregroundStyle(.white.opacity(0.8))
                        .padding(.top, 16)
                }
            }
            .buttonStyle(.plain)

            // Description
            Text(condition.description)
                .font(.title3)
                .foregroundStyle(.white.opacity(0.9))

            // High / Low
            Text("H:\(condition.high)  L:\(condition.low)")
                .font(.body)
                .foregroundStyle(.white.opacity(0.7))
        }
    }
}

// MARK: - Hourly Forecast Card
// A horizontally scrolling row of hourly temperatures and icons.

struct HourlyForecastCard: View {
    let hourly: [HourlyForecast]

    var body: some View {
        VStack(alignment: .leading) {
            // Section label
            Label("HOURLY FORECAST", systemImage: "clock")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
                .padding(.horizontal, 16)

            Divider()
                .background(.white.opacity(0.3))
                .padding(.horizontal, 16)

            // Horizontal scroll of hourly items
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(hourly) { hour in
                        VStack(spacing: 8) {
                            // Hour label
                            Text(hour.hour)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.8))

                            // Weather icon
                            Image(systemName: hour.symbolName)
                                .font(.title2)
                                .foregroundStyle(.white)
                                .symbolRenderingMode(.multicolor) // Use Apple's built-in colors

                            // Temperature
                            Text("\(hour.temperature)")
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        }
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)    // Frosted glass effect
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }
}

// MARK: - Daily Forecast Card
// A vertical list of the 7-day forecast.

struct DailyForecastCard: View {
    let daily: [DailyForecast]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Section label
            Label("7-DAY FORECAST", systemImage: "calendar")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.top, 12)

            Divider()
                .background(.white.opacity(0.3))
                .padding(.horizontal, 16)
                .padding(.top, 8)

            // Each day row
            ForEach(daily) { day in
                HStack {
                    // Day name -- fixed width so columns line up
                    Text(day.day)
                        .font(.body)
                        .foregroundStyle(.white)
                        .frame(width: 100, alignment: .leading)

                    // Weather icon
                    Image(systemName: day.symbolName)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 30)

                    Spacer()

                    // Low temperature
                    Text("\(day.low)")
                        .font(.body)
                        .foregroundStyle(.white.opacity(0.5))

                    // Temperature bar
                    // A simple visual bar showing the temperature range.
                    TemperatureBar(low: day.low, high: day.high, rangeLow: 50, rangeHigh: 75)
                        .frame(width: 80, height: 6)

                    // High temperature
                    Text("\(day.high)")
                        .font(.body)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

                if day.id != daily.last?.id {
                    Divider()
                        .background(.white.opacity(0.15))
                        .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 4)
        }
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }
}

// MARK: - Temperature Bar
// A small gradient bar that visually represents a day's temperature range.

struct TemperatureBar: View {
    let low: Int
    let high: Int
    let rangeLow: Int   // Lowest temp across all days (for scaling)
    let rangeHigh: Int  // Highest temp across all days

    var body: some View {
        GeometryReader { geometry in
            let totalRange = CGFloat(rangeHigh - rangeLow)
            let barWidth = geometry.size.width

            // Calculate where this day's range falls within the overall range
            let startFraction = CGFloat(low - rangeLow) / totalRange
            let endFraction = CGFloat(high - rangeLow) / totalRange

            ZStack(alignment: .leading) {
                // Background track
                Capsule()
                    .fill(.white.opacity(0.2))

                // Colored portion
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [.blue, .green, .yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: barWidth * (endFraction - startFraction))
                    .offset(x: barWidth * startFraction)
            }
        }
    }
}

// MARK: - Weather Detail Grid
// A 2x2 grid showing additional weather details.

struct WeatherDetailGrid: View {
    let condition: WeatherCondition

    // Define a 2-column grid
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            // Feels Like
            DetailCard(
                title: "FEELS LIKE",
                systemImage: "thermometer.medium",
                value: "\(condition.feelsLike)",
                unit: "F",
                footnote: "Similar to the actual temperature."
            )

            // Humidity
            DetailCard(
                title: "HUMIDITY",
                systemImage: "humidity",
                value: "\(condition.humidity)",
                unit: "%",
                footnote: "The dew point is 54 right now."
            )

            // Wind
            DetailCard(
                title: "WIND",
                systemImage: "wind",
                value: "\(condition.windSpeed)",
                unit: "mph",
                footnote: "West-northwest gusts up to 20 mph."
            )

            // UV Index
            DetailCard(
                title: "UV INDEX",
                systemImage: "sun.max.fill",
                value: "\(condition.uvIndex)",
                unit: "",
                footnote: uvDescription(for: condition.uvIndex)
            )
        }
        .padding(.horizontal, 16)
    }

    // Helper to describe UV level
    func uvDescription(for index: Int) -> String {
        switch index {
        case 0...2:  return "Low risk for the average person."
        case 3...5:  return "Moderate. Wear sunscreen."
        case 6...7:  return "High. Seek shade during midday."
        case 8...10: return "Very high. Extra protection needed."
        default:     return "Extreme. Avoid sun exposure."
        }
    }
}

// MARK: - Detail Card
// A single tile in the 2x2 weather detail grid.

struct DetailCard: View {
    let title: String
    let systemImage: String
    let value: String
    let unit: String
    let footnote: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with icon and title
            Label(title, systemImage: systemImage)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))

            // Large value
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(size: 34, weight: .medium))
                    .foregroundStyle(.white)

                Text(unit)
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()

            // Footnote
            Text(footnote)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, minHeight: 140, alignment: .leading)
        .padding(12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Preview

#Preview {
    WeatherView()
}
