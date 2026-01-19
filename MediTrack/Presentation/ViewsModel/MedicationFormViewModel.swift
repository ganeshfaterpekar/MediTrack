//
//  MedicationFormViewModel.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import Foundation

@MainActor
final class MedicationFormViewModel: ObservableObject {
    @Published var name: String
    @Published var dosage: String
    @Published var frequency: Frequency

    @Published private(set) var isSaving = false
    @Published private(set) var errorMessage: String?

    private let medicatonService: MedicationService
    private let existingId: String?

    init(medication: Medication?, medicationService: MedicationService) {
        existingId = medication?.id.uuidString
        name = medication?.name ?? ""
        dosage = medication?.dosage ?? ""
        frequency = medication?.frequency ?? .daily
        medicatonService = medicationService
    }

    func save() async -> Medication? {
        errorMessage = nil
        isSaving = true
        defer { isSaving = false }

        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Name is required"
            return nil
        }

        guard !dosage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Dosage is required"
            return nil
        }

        do {
            if let id = existingId {
                return try await medicatonService.updateMedication(id: id, name: name, dosage: dosage, frequency: frequency.rawValue)
            }

            return try await medicatonService.createMedications(name: name, dosage: dosage, frequency: frequency.rawValue)
        } catch {
            errorMessage = error.localizedDescription
            return nil
        }
    }
}
