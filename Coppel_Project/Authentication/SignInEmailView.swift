//
//  SignInEmailView.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var showSignInView: Bool = true
    
    func signUp() async throws{ //Connect to the server to sign up user
        guard !email.isEmpty, !password.isEmpty else{ //If the text field is not empty
            print("No email or password found")
            return
        }
        //Get the user data and then send the email and userID to firestore
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(userID: returnedUserData.uid, email: returnedUserData.email, photoURL: returnedUserData.photoURL) //Create a user from the DBUser
        try await UserManager.shared.createNewUser(user: user)
        
        
        self.showSignInView = false //If the authentication is successful, hide the sign in fullscreen cover
        print("Sign Up Successful")
        print(returnedUserData)
    }
    
    func LogIn() async throws{
        guard !email.isEmpty, !password.isEmpty else{//If the text field is not empty
            print("No email or password found")
            return
        }
        //Get the user data and then send the email and userID to firestore

        let returnedUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        let user = DBUser(userID: returnedUserData.uid, email: returnedUserData.email, photoURL: returnedUserData.photoURL) //Create a user from the DBUser
        try await UserManager.shared.createNewUser(user: user)
    
        self.showSignInView = false //If the authentication is successful, hide the sign in fullscreen cover
        print("Log In successful")

    }
    
    func resetPassword(email: String) async throws{
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
}

struct SignInEmailView: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    
    @StateObject var authenticationManager = AuthenticationManager()
    @StateObject var allUsersViewModel = AllUsersViewModel()
    @State var allUsersArray: [String] = []
    
    @Binding var showSignInView: Bool
    @State private var success: Bool = false
    @State var showError: Bool = false
    @FocusState private var nameIsFocused: Bool
    
    @State var showSetUpUser: Bool = false
    
    @StateObject var addInfoViewModel = AddInfoViewModel()
    @State var userInfo: UserInfo = UserInfo()
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Email:")
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding(.bottom, 10)
                .focused($nameIsFocused)
            
            
            Text("Password:")
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding(.bottom, 10)
                .focused($nameIsFocused)
            
            Button{
                Task{
                    do{
                        try await viewModel.signUp()
                        
                        userInfo.user.user_id = try authenticationManager.getAuthenticatedUser().uid
                        
                        userInfo.user = UserData(user_id: userInfo.user.user_id , nombre: "", apellidos: "", razonSocial: "", rfc: "", estado: "", ciudad: "", calle: "", codigoPostal: "", tipo_usuario: "")
                        
                        try await addInfoViewModel.addUserInfo(user: userInfo.user)
                        
                        
                        
                        
//                        showSetUpUser = true
                        showSignInView = false
                        
                    }
                }

                
            }label:{
                Text("Register")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .frame(height: 55)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
        }
        .alert(isPresented: $showError){
            Alert(title: Text("Error"), message: Text("Try again with a valid email or password"),dismissButton: .default(Text("Ok")))
        }
//        .sheet(isPresented: $showSetUpUser, content: {
//            SetUpUserView(showSetUpUser: $showSetUpUser, showSignInView: $showSignInView)
//        })
    }
}

#Preview {
    NavigationStack{
        SignInEmailView(showSignInView: .constant(false))
    }
}

