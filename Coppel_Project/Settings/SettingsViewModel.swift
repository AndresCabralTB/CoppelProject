//
//  SettingsViewModel.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject{
    @Published var authProviders: [AuthProviderOption] = []
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws{
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword(password: String) async throws {
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func loadAuthProviders(){
        if let providers = try? AuthenticationManager.shared.getProvider() {
            authProviders = providers
        }
    }
}
