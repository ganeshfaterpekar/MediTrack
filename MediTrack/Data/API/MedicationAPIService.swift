//
//  MedicationAPIService.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//


import Foundation
import HENetworking

class MedicationAPIService: MedicationService {

    private let networkClient: HTTPClient
    private let authConfig: AuthConfig
    
    init(networkClient: HTTPClient, authConfig: AuthConfig) {
        self.networkClient = networkClient
        self.authConfig = authConfig
    }
    
    func listMedications() async throws -> [Medication] {
        let response = try await networkClient.send(
            Endpoint.medications(
                authService: authConfig
            ),
            decodeTo: ListMedicationResponse.self)
        
        return response.data.compactMap { $0.toDomain() }
    }
    
    func createMedications(name: String, dosage: String, frequency: String) async throws -> Medication {
        let medication = RequestPayload.CreateMedication(name: name, dosage: dosage, frequency: frequency)
        let response = try await networkClient.send(
            Endpoint.createMedication(
                authService: authConfig,
                medication: medication
            ),
            decodeTo: CreateMedicationResponse.self
        )
        return response.data.toDomain()
        
    }
    
    func getMedicationDetails(id: UUID) async throws -> Medication {
        let response = try await networkClient.send(
            Endpoint.getMedicationDetails(
                authService: authConfig,
                id: id
            ),
            decodeTo: Medication.self)
        
        return response
    }
    
    func updateMedication(id: String, name: String, dosage: String, frequency: String ) async throws -> Medication {
        let medication = RequestPayload.UpdateMedication(name: name, dosage: dosage, frequency: frequency)
        let response = try await networkClient.send(
            Endpoint.updateMedication(
                authService: authConfig,
                id: id,
                medication: medication),
            decodeTo: UpdateMedicationResponse.self)
        return response.data.toDomain()
    }
    
    func deleteMedication(id: UUID) async throws  -> String {
        let response = try await networkClient.send(
            Endpoint.deleteMedication(
                authService: authConfig,
                id: id
            ),
            decodeTo: DeleteMedicationResponse.self)
        
        return response.data.id
        
    }
    
   
}




    
