//
//  MediTrackApp.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 12/1/2026.
//

import SwiftUI
import HENetworking

@main
struct MediTrackApp: App {
   
    private let container: AppContainer
    
    init() {
        self.container = .live()
    }

    var body: some Scene {
        WindowGroup {
            MedicationListView(viewModel: container.makeMedicationListVM())
                .environment(\.appContainer,container)
        }
    }
}


private struct AppContainerKey: EnvironmentKey {
    static let defaultValue: AppContainer = .live()
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}

