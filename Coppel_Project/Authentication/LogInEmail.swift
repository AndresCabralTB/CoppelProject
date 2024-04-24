//
//  LogInEmail.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

struct LogInEmail: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @StateObject private var viewModel = SignUpEmailViewModel()
    @Binding var showSignInView: Bool
    @State private var success: Bool = false
    @State var showError: Bool = false
    @State public var passwordResetPopOver: Bool = false
    @State public var noEmail: Bool = false
    @FocusState private var nameIsFocused: Bool
    
    
    
    
    var body: some View {
        ZStack{
            
            Color.teal
                .ignoresSafeArea()
                .ignoresSafeArea(.keyboard)
            
            
            LinearGradient(gradient: Gradient(colors: [.blue,.teal]), startPoint: .top, endPoint: .center)
            
            
            VStack{
                Spacer()
                Text("Hey, Welcome Back!")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(.top, 25)
                
                Spacer()
                
                HStack{
                    Spacer()
                    
                    Image(systemName: "sailboat.fill")
                        .resizable()
                        .frame(width: 75,height: 75)
                        .padding(.vertical, -5)
                        .padding(.horizontal, 10)
                    Spacer()
                }
                VStack(spacing: 10){
                    Spacer()
                    
                    Text("Log In")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    VStack(alignment: .leading){
                        Text("Email:")
                        
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .background(Color.gray.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                            .focused($nameIsFocused)
                        
                        
                        Text("Password:")
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color.gray.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(maxWidth: .infinity)
                            .focused($nameIsFocused)
                        
                        
                        HStack(alignment: .bottom){
                            Spacer()
                            Button{
                                if !viewModel.email.isEmpty{
                                    Task{
                                        do{
                                            try await viewModel.resetPassword(email: viewModel.email)
                                            passwordResetPopOver = true
                                        }
                                    }
                                }else{
                                    noEmail = true
                                }
                            }label:{
                                Text("Forgot Password?")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.gray)
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 10)
                        
                        Button{ //Create a task because it needs to connect to the server and it may fail
                            Task{
                                do{
                                    try await viewModel.LogIn() //Call the login function from SignUpEmailViewModel
                    
                                    
                                    showSignInView = viewModel.showSignInView
                                } catch{
                                }
                            }
                            
                        }label:{
                            Text("Continue")
                                .font(.headline)
                                .foregroundStyle(Color.white)
                                .frame(width: UIScreen.main.bounds.width * 0.8,height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        }
                        
                        
                        logInWithSection
                        
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.70)
                .background(colorScheme == .dark ? .black : .white)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
            }
            .ignoresSafeArea()
            .ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        
        .ignoresSafeArea()
        .ignoresSafeArea(.keyboard)
        
        .alert(isPresented: $showError){
            Alert(title: Text("Error"), message: Text("Try again with a valid email or password"),dismissButton: .default(Text("Ok")))
            
        }
        .alert("Message", isPresented: $passwordResetPopOver){
            Button("Ok", role: .cancel){}
        } message: {
            Text("You will receive an email to reset your password")
                .font(.footnote)
        }
        .alert("Message", isPresented: $noEmail){
            Button("Ok", role: .cancel){}
        } message: {
            Text("Enter an email")
                .font(.footnote)
        }
        .onTapGesture {
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
            nameIsFocused = false
        }
        
    }
}

extension LogInEmail{
    private var logInWithSection: some View {
        
        
        VStack(spacing: 20){
            Text("Or continue with")
                .font(.headline)
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity)
            
            if self.colorScheme == .light{
                SignInWithAppleButton { request in
                    
                } onCompletion: { result in
                    
                }
                .frame(height: 55)
                .signInWithAppleButtonStyle(.black)
            } else{
                SignInWithAppleButton { request in
                    
                } onCompletion: { result in
                    
                }
                .frame(height: 55)
                .signInWithAppleButtonStyle(.white)
            }
            
            
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)){
                Task{
                    do{
                        try await authenticationViewModel.signInGoogle()
                        //If the user logs in once
                        showSignInView = false
                        
                    } catch{
                        print(error)
                    }
                }
            }
            .frame(height: 55)
        }
        
        
    }
}

// Vista personalizada para el botón de regreso.
struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Button(action: {
                // Acción para cerrar la vista actual y volver a la anterior.
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    // Ícono personalizado para el botón de regreso.
                    Image(systemName: "chevron.left.circle.fill")
                        .bold()
                        .padding(.leading,10)
                        .foregroundColor(.orange)
                        .font(.system(size: 20))
                }
            }
        }
    }
}


#Preview {
    LogInEmail(showSignInView: .constant(false))
}

