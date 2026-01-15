//
//  MedicationListViewModelTest.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 15/1/2026.
//

import Foundation
import XCTest
@testable import MediTrack

@MainActor
final class MedicationListViewModelTests: XCTestCase {
    
    private func makeMedication(id: UUID = UUID(), name: String,dosage: String, frequency: Frequency) -> Medication {
        Medication(
            id: id,
            name: name,
            dosage: dosage,
            frequency: frequency
        )
    }
    
    func testLoad_success_updatesMedications_andKeepsErrorNil() async throws {
           // Arrange
        let service = MedicationServiceMock()
        let m1 = makeMedication(name: "Panadol",dosage:"100mg",frequency: .daily)
        let m2 = makeMedication(name: "Aspirin",dosage:"100mg",frequency: .asNeeded)
           service.listResult = .success([m1, m2])

        let sut = MedicationListViewModel(medicationService: service)

           // Act
        try await sut.load()

           // Assert
        XCTAssertEqual(service.listCallCount, 1)
        XCTAssertEqual(sut.medications, [m1, m2])
        XCTAssertNil(sut.errorMessage)
        XCTAssertFalse(sut.isEmpty)
    }
    
    func testDelete_success_callsServiceWithCorrectID_andRemovesLocalItem() async {
            // Arrange
        let service = MedicationServiceMock()
        let id1 = UUID()
        let id2 = UUID()
        let m1 = makeMedication(id: id1,name: "Panadol",dosage:"100mg",frequency: .daily)
        let m2 = makeMedication(id: id2,name: "Aspirin",dosage:"100mg",frequency: .asNeeded)
        let sut = MedicationListViewModel(medicationService: service)
        sut._setMedicationsForTests([m1, m2])

            // Act (delete first row)
        await sut.delete(offsets: IndexSet(integer: 0))

            // Assert
        XCTAssertEqual(service.deleteCalls, [id1])
        XCTAssertEqual(sut.medications, [m2])
        XCTAssertNil(sut.errorMessage)
    }
    
}


