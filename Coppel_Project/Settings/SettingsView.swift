//
//  SettingsView.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var tagViewModel: TagViewModel
//    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    @StateObject private var viewModel = SettingsViewModel()
    @StateObject var authenticationManager = AuthenticationManager()
    
    @Binding var showSignInView: Bool
    @State public var passwordResetPopOver: Bool = false
    @State var newPasswordPopOver: Bool = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
                    Button{
                        Task{
                            do{
                                try viewModel.signOut()
                                authenticationManager.logOut()
                                tagViewModel.tag = 0
                                showSignInView = true
                                print(showSignInView)
                                print("Signed out")
                            } catch{
                                print("Log out error")
                            }
                        }
                        showSignInView = true
                    } label: {
                        Text("Sign Out")
                            .foregroundStyle(Color.black)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }    }
}

extension SettingsView{
    private var emailSection: some View {
        
        VStack{
            
            Button("Reset Password"){
                Task{
                    do{
                        try await viewModel.resetPassword()
                        passwordResetPopOver = true
                    }
                }
            }
            Button("Update Password"){
                Task{
                    do{
                        newPasswordPopOver = true
                        try await viewModel.updatePassword(password: password)
                        print(password)
                        password = ""
                    }
                }
            }.popover(isPresented: $newPasswordPopOver, content: {
                VStack(alignment: .leading, spacing: 10){
                    Text("Password Reset")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    Text("Enter your new password")
                        .font(.headline)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button(action: {
                        newPasswordPopOver = false
                    }, label: {
                        Text("Enter")
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
                    Spacer()
                }
                .navigationTitle("")
                .padding()
            })
            
            .alert("Message", isPresented: $passwordResetPopOver){
                Button("Ok", role: .cancel){}
            } message: {
                Text("You will receive an email to reset your password")
                    .font(.footnote)
            }
        }
    }
    
}

#Preview {
//    HomePageView(showSignInView: .constant(true))
    SettingsView(showSignInView: Binding.constant(false))
}
