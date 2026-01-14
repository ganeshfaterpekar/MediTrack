//
//  MedicationListView.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import SwiftUI
import HEUILibrary

struct MedicationListView: View {
    @Environment(\.appContainer) private var container
    
    @StateObject var viewModel: MedicationListViewModel
    @State private var showAdd = false
    @State private var selectedMedication: Medication?
    
    init(viewModel: MedicationListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isEmpty {
                    ContentUnavailableView(
                        "No Medications",
                        systemImage: "pills",
                        description: Text("Please add medications to get started."))
                }
                else {
                    List {
                        ForEach(viewModel.medications) { medication in
                            Button {
                                selectedMedication = medication
                            } label: {
                                MedicationUI.makeMedicationListRowItem(medication: medication)
                            }.buttonStyle(.plain)
                        }.onDelete { offsets in
                            Task {
                                await viewModel.delete(offsets: offsets)
                            }
                        }
                        
                    }.listStyle(.plain)
                }
           }.navigationTitle("Medications")
            .toolbar {
                Button {
                       showAdd = true
                } label: {
                        Image(systemName: "plus")
                 }
              }
            .sheet(isPresented: $showAdd) {
                MedicationFormView(viewModel: container.makeMakeMediticationFormVM()) { medication in
                    showAdd = false
                    Task {try? await viewModel.load() }
                }
            }
            .sheet(item: $selectedMedication) { medication in
                MedicationFormView(viewModel: container.makeMakeMediticationFormVM(medication)) { _ in
                    selectedMedication = nil
                    Task {try? await viewModel.load() }
                }
            }
           
           }.task {
            try? await viewModel.load()
          }
    }
    
   

}

