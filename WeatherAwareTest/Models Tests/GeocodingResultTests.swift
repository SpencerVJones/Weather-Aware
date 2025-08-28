//  GeocodingResultTests.swift
//  WeatherAwareTest
//  Created by Spencer Jones on 8/26/25

import XCTest
@testable import WeatherAware

final class GeocodingResultTests: XCTestCase {

    func testEncodingAndDecoding_fullData() throws {
        let original = GeocodingResult(
            name: "San Francisco",
            localNames: ["en": "San Francisco", "es": "San Francisco"],
            lat: 37.7749,
            lon: -122.4194,
            country: "US",
            state: "California"
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(original)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(GeocodingResult.self, from: data)

        XCTAssertEqual(decoded.name, original.name)
        XCTAssertEqual(decoded.localNames, original.localNames)
        XCTAssertEqual(decoded.lat, original.lat)
        XCTAssertEqual(decoded.lon, original.lon)
        XCTAssertEqual(decoded.country, original.country)
        XCTAssertEqual(decoded.state, original.state)
    }

    func testEncodingAndDecoding_missingOptionals() throws {
        let original = GeocodingResult(
            name: "Paris",
            localNames: nil,
            lat: 48.8566,
            lon: 2.3522,
            country: "FR",
            state: nil
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(original)

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(GeocodingResult.self, from: data)

        XCTAssertEqual(decoded.name, original.name)
        XCTAssertNil(decoded.localNames)
        XCTAssertEqual(decoded.lat, original.lat)
        XCTAssertEqual(decoded.lon, original.lon)
        XCTAssertEqual(decoded.country, original.country)
        XCTAssertNil(decoded.state)
    }

    func testCodingKeys_mappingLocalNames() throws {
        // JSON with snake_case "local_names"
        let json = """
        {
            "name": "Berlin",
            "local_names": {"de": "Berlin"},
            "lat": 52.52,
            "lon": 13.405,
            "country": "DE",
            "state": null
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(GeocodingResult.self, from: json)

        XCTAssertEqual(decoded.name, "Berlin")
        XCTAssertEqual(decoded.localNames, ["de": "Berlin"])
        XCTAssertEqual(decoded.lat, 52.52)
        XCTAssertEqual(decoded.lon, 13.405)
        XCTAssertEqual(decoded.country, "DE")
        XCTAssertNil(decoded.state)
    }
}
