//
//  MedicationServiceMock.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 15/1/2026.
//

import Foundation
@testable import MediTrack

final class MedicationServiceMock: MedicationService {
    var listResult: Result<[Medication], Error> = .success([])
    var detailsResultByID: [UUID: Result<Medication, Error>] = [:]
    var createResult: Result<Medication, Error> = .failure(TestError.notStubbed)
    var updateResult: Result<Medication, Error> = .failure(TestError.notStubbed)
    var deleteResultByID: [UUID: Result<String, Error>] = [:]

    private(set) var listCallCount = 0
    private(set) var detailsCalls: [UUID] = []
    private(set) var createCalls: [(name: String, dosage: String, frequency: String)] = []
    private(set) var updateCalls: [(id: String, name: String, dosage: String, frequency: String)] = []
    private(set) var deleteCalls: [UUID] = []

    func listMedications() async throws -> [Medication] {
        listCallCount += 1
        return try listResult.get()
    }

    func getMedicationDetails(id: UUID) async throws -> Medication {
        detailsCalls.append(id)
        if let result = detailsResultByID[id] { return try result.get() }
        throw TestError.notStubbed
    }

    func createMedications(name: String, dosage: String, frequency: String) async throws -> Medication {
        createCalls.append((name, dosage, frequency))
        return try createResult.get()
    }

    func updateMedication(id: String, name: String, dosage: String, frequency: String) async throws -> Medication {
        updateCalls.append((id, name, dosage, frequency))
        return try updateResult.get()
    }

    func deleteMedication(id: UUID) async throws -> String {
        deleteCalls.append(id)
        if let result = deleteResultByID[id] { return try result.get() }
        return id.uuidString
    }
}

enum TestError: Error {
    case notStubbed
}
