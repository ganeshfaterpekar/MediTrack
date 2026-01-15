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
    @Published var errorMessage: String?
    var isEmpty: Bool { medications.isEmpty }
    private let medicationService: MedicationService
    
    init(medicationService: MedicationService) {
        self.medicationService = medicationService
    }
    
    
    func load() async throws {
        do {
            medications  = try await medicationService.listMedications()
        }catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func delete(offsets: IndexSet) async {
        let ids = offsets.map { medications[$0].id }
          do {
               for id in ids {
               _ = try await medicationService.deleteMedication(id: id)
            }
            medications.remove(atOffsets: offsets)
           } catch {
                errorMessage = error.localizedDescription
          }
    }
}

#if DEBUG
@MainActor
extension MedicationListViewModel {
    func _setMedicationsForTests(_ meds: [Medication]) {
        self.medications = meds
    }
}
#endif
