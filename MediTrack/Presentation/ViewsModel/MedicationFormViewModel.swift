//
//  AddMedicationViewModel.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import Foundation

@MainActor
final class AddMedicationViewModel: ObservableObject {
    @Published var name: String
    @Published var dosage: String
    @Published var frequency: Frequency
    
    
    init(name: String, dosage: String, frequency: Frequency) {
        self.name = name
        self.dosage = dosage
        self.frequency = frequency
    }
    
    
    func save() async {
        
    }
    
}
