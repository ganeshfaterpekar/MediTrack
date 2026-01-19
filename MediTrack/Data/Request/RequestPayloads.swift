//
//  RequestPayloads.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import Foundation

enum RequestPayload {
    struct CreateMedication: Encodable {
        let name: String
        let dosage: String
        let frequency: String
    }

    struct UpdateMedication: Encodable {
        let name: String?
        let dosage: String?
        let frequency: String?
    }

    struct Medication: Decodable {
        let id: UUID
        let username: String
        let name: String
        let dosage: String
        let frequency: String
        let createdAt: Date
        let updatedAt: Date
    }
}
