//
//  MedicationListViewModel.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import SwiftUI

@MainActor
final class MedicationListViewModel: ObservableObject {
    
    @Published private(set) var medications: [Medication] = []
    @Published private(set) var isEmpty: Bool = true
    
    private let medicationService: MedicationService
    
    init(medicationService: MedicationService) {
        self.medicationService = medicationService
    }
    
    
    func load() async throws {
        medications  = try await medicationService.getMedications()
        isEmpty = medications.isEmpty
    }
}
