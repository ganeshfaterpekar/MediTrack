//
//  ResponsePayloads.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 12/1/2026.
//

import Foundation

struct MedicationResponse: Codable {
    let id: UUID
    let username: String
    let name: String
    let dosage: String
    let frequency: FrequencyResponse
    let createdAt: Date
    let updatedAt: Date
}

enum FrequencyResponse: String, Codable {
    case daily
    case twice_daily
    case weekly
    case as_needed
}

extension MedicationResponse {
    func toDomain() -> Medication {
        Medication(id: id,
                   name: name,
                   dosage: dosage,
                   frequency: frequency.toDomain())
    }
}

extension FrequencyResponse {
    func toDomain() -> Frequency {
        switch self {
        case .daily: return .daily
        case .twice_daily: return .twiceDaily
        case .weekly: return .weekly
        case .as_needed: return .asNeeded
        }
    }
}

struct HealthStatus: Decodable {
    let status: String
}

struct DeletedId: Decodable {
    let id: String
}

struct ListMedicationResponse: Decodable {
    let data: [MedicationResponse]
}

struct DeleteMedicationResponse: Decodable {
    let data: DeletedId
}

struct CreateMedicationResponse: Decodable {
    let data: MedicationResponse
}

struct UpdateMedicationResponse: Decodable {
    let data: MedicationResponse
}
