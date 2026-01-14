// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Foundation

public struct ThumbnailDescriptionView: View {
    let name: String
    let dosage: String
    let frequency: String
    let image: String

    public init(name: String, dosage: String, frequency: String, image: String) {
        self.name = name
        self.dosage = dosage
        self.frequency = frequency
        self.image = image
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {

            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .lineLimit(1)

                Text(dosage)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(frequency)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ThumbnailDescriptionView(
            name: "Metformin",
            dosage: "500 mg",
            frequency: "Daily at 9:00 AM • With food",
            image: "pills"
        )
        .padding()
}
