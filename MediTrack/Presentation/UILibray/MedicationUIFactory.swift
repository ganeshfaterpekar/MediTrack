//
//  MedicationUI.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

import HEUILibrary

enum MedicationUIFactory {
  
   static func makeMedicationListRowItem(medication: Medication) -> ThumbnailDescriptionView {
        return ThumbnailDescriptionView(name: medication.name, dosage: medication.dosage, frequency: medication.frequency.displayTitle, image: "pills")
    }
}
