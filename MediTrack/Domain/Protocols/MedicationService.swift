//
//  MedicationService.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import Foundation

protocol MedicationService {
    func listMedications() async throws -> [Medication]
    func getMedicationDetails(id: UUID) async throws -> Medication
    func createMedications(name: String, dosage: String, frequency: String) async throws -> Medication
    func updateMedication(id: String, name: String, dosage: String, frequency: String) async throws -> Medication
    func deleteMedication(id: UUID) async throws  -> String
}
