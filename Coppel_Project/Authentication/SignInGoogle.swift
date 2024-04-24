//
//  SignInGoogle.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

@MainActor
final class SignInGoogle{
    
    func signInGoogle() async throws -> GoogleSignInResultModel{
        guard let topVC = Utilities.shared.topViewController() else{
            throw URLError(.badServerResponse)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        return tokens
    }
}
