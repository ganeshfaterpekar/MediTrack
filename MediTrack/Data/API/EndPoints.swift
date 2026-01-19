//
//  EndPoints.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import Foundation
import HENetworking

enum Endpoint {
    static let baseUrl = "api-jictu6k26a-uc.a.run.app"

    static func health() -> HTTPRequest {
        let request = HTTPRequest(
            host: baseUrl,
            path: "/health"
        )
        return request
    }

    static func medications(authService: AuthConfig) -> HTTPRequest {
        let username = authService.getUser()
        let request = HTTPRequest(
            host: baseUrl,
            path: "/users/\(username)/medications",
            headers: ["x-api-key": authService.getApiKey()]
        )

        return request
    }

    static func createMedication(authService: AuthConfig, medication: RequestPayload.CreateMedication) -> HTTPRequest {
        let username = authService.getUser()
        let body = try? JSONEncoder().encode(medication)
        let request = HTTPRequest(
            host: baseUrl,
            path: "/users/\(username)/medications",
            headers: ["x-api-key": authService.getApiKey(), "Content-Type": "application/json"],
            method: .post,
            body: body
        )
        return request
    }

    static func getMedicationDetails(authService: AuthConfig, id: UUID) -> HTTPRequest {
        let username = authService.getUser()
        let request = HTTPRequest(
            host: baseUrl,
            path: "/users/\(username)/medications/\(id)",
            headers: ["x-api-key": authService.getApiKey(), "Accept": "application/json"]
        )

        return request
    }

    static func updateMedication(authService: AuthConfig, id: String, medication: RequestPayload.UpdateMedication) -> HTTPRequest {
        let username = authService.getUser()
        let body = try? JSONEncoder().encode(medication)
        let request = HTTPRequest(
            host: baseUrl,
            path: "/users/\(username)/medications/\(id.lowercased())",
            headers: ["x-api-key": authService.getApiKey(), "Content-Type": "application/json"],
            method: .put,
            body: body
        )
        return request
    }

    static func deleteMedication(authService: AuthConfig, id: UUID) -> HTTPRequest {
        let username = authService.getUser()
        let request = HTTPRequest(
            host: baseUrl,
            path: "/users/\(username)/medications/\(id.uuidString.lowercased())",
            headers: ["x-api-key": authService.getApiKey(), "Content-Type": "application/json"],
            method: .delete
        )
        return request
    }
}
