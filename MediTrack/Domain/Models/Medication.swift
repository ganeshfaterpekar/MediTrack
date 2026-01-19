//
//  Medication.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 12/1/2026.
//
import Foundation

struct Medication: Decodable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let dosage: String
    let frequency: Frequency
}
