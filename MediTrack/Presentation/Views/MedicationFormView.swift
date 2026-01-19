//
//  MedicationFormView.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import SwiftUI

struct MedicationFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appContainer) private var container
    @StateObject var viewModel: MedicationFormViewModel

    var onSaved: (Medication?) -> Void

    init(viewModel: MedicationFormViewModel, onSaved: @escaping (Medication?) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSaved = onSaved
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Medication") {
                    TextField("Name", text: $viewModel.name)
                        .limitTextLength($viewModel.name, max: 10)
                    TextField("Dosage", text: $viewModel.dosage)
                        .limitTextLength($viewModel.dosage, max: 100)
                }

                Section("Please select Medication Frequeny") {
                    Picker("Medication Freqency", selection: $viewModel.frequency) {
                        ForEach(Frequency.allCases, id: \.self) { freq in
                            Text(freq.displayTitle).tag(freq)
                        }
                    }
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundStyle(.red)
                }
            }.navigationTitle("Medication")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button(viewModel.isSaving ? "Saving..." : "Save") {
                            Task {
                                if let saved = await viewModel.save() {
                                    onSaved(saved)
                                    dismiss()
                                }
                            }
                        }.disabled(viewModel.isSaving)
                    }
                }
        }
    }
}
