//
//  AuthenticationViewModel.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 02/04/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthenticationViewModel:ObservableObject{
    // Unhashed nonce.
    let signInApplhelper = SignInAppleHelper()
    
    
    func signInGoogle() async throws {

        let helper = SignInGoogle()
        let tokens = try await helper.signInGoogle()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(userID: authDataResult.uid, email: authDataResult.email, photoURL: authDataResult.photoURL) //Create a user from the DBUser
        try await UserManager.shared.createNewUser(user: user)
        
    }
    
    func signInApple() async throws{
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        let user = DBUser(userID: authDataResult.uid, email: authDataResult.email, photoURL: authDataResult.photoURL) //Create a user from the DBUser
        try await UserManager.shared.createNewUser(user: user)
    }
}
