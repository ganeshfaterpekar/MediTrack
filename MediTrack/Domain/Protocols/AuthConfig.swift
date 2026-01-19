//
//  AuthConfig.swift
//  MediTrack
//
//  Created by Ganesh Faterpekar on 13/1/2026.
//

protocol AuthConfig {
    func getUser() -> String
    func getApiKey() -> String
}
