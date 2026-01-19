//
//  JSONEncodersDecoders.swift
//  HENetworking
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//
import Foundation

import Foundation

public extension JSONDecoder {
    static var defaultAPIDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)

            // Try ISO-8601 with fractional seconds first
            do {
                let f = ISO8601DateFormatter()
                f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                if let d = f.date(from: value) { return d }
            }

            // Fallback: ISO-8601 without fractional seconds
            do {
                let f = ISO8601DateFormatter()
                f.formatOptions = [.withInternetDateTime]
                if let d = f.date(from: value) { return d }
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid ISO8601 date: \(value)"
            )
        }
        return decoder
    }
}

public extension JSONEncoder {
    static var defaultAPIEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()

            let f = ISO8601DateFormatter()
            f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            try container.encode(f.string(from: date))
        }
        return encoder
    }
}
