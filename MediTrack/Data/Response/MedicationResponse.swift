//
//  MedicationResponse.swift
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
        Medication(id: self.id,
                   name: self.name,
                   dosage: self.dosage,
                   frequency: self.frequency.toDomain())
    }
}

extension FrequencyResponse {
    func toDomain() -> Frequency {
        switch self {
        case .daily: return .daily(time: MedicationTime.firstDoseTime)
        case .twice_daily: return .twice_daily(first: MedicationTime.firstDoseTime, second: MedicationTime.SecondDoseTine)
        case .weekly: return .weekly(days: [Weekdays.doseDay], time: MedicationTime.firstDoseTime)
        case .as_needed:
            return .as_needed
        }
    }
}
