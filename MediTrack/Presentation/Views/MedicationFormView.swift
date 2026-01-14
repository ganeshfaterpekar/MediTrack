//
//  AddMedicationView.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import SwiftUI
struct AddMedicationView: View {

    @StateObject var viewModel: AddMedicationViewModel 
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Medication") {
                    TextField("Name",text: $viewModel.name)
                    TextField("Dosage",text: $viewModel.dosage)
                }
                
                Section("Frequeny") {
                    Text("Frequeny Here")
                }
            }.navigationTitle("Medication")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {}
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            Task {
//                                if let saved =  await viewModel.save() {
//                                    
//                                }
                            }
                        }
                    }
                }
        }
        
    }
}
