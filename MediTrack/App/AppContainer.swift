//
//  AppContainer.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 14/1/2026.
//

import HENetworking

final class AppContainer {
    let httpClient: HTTPClient
    let authConfig: AuthConfig
    let medicationService: MedicationService

    init(httpClient: HTTPClient, authConfig: AuthConfig, medicationService: MedicationService) {
        self.httpClient = httpClient
        self.authConfig = authConfig
        self.medicationService = medicationService
    }

    @MainActor
    func makeMedicationListVM() -> MedicationListViewModel {
        MedicationListViewModel(medicationService: medicationService)
    }

    @MainActor
    func makeMakeMediticationFormVM(_ medication: Medication? = nil) -> MedicationFormViewModel {
        MedicationFormViewModel(medication: medication, medicationService: medicationService)
    }
}

extension AppContainer {
    static func live() -> AppContainer {
        let httpClient = URLSessionSharedHTTPClient(decoder: .defaultAPIDecoder)
        let auth = AuthConfigService()
        let medService = MedicationAPIService(networkClient: httpClient, authConfig: auth)

        return AppContainer(httpClient: httpClient, authConfig: auth, medicationService: medService)
    }
}
