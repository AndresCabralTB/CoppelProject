

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import _AuthenticationServices_SwiftUI



struct AuthenticationView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showSignInView: Bool
    @StateObject private var viewModel = AuthenticationViewModel()
    @FocusState private var nameIsFocused: Bool
    
    @StateObject var authenticationManager = AuthenticationManager()
    @StateObject var allUsersViewModel = AllUsersViewModel()
    @State var allUsersArray: [String] = []
    
    var body: some View {
        
        
        NavigationStack{
            ZStack{
                
                Color.teal
                    .ignoresSafeArea()
                    .ignoresSafeArea(.keyboard)
                
                LinearGradient(gradient: Gradient(colors: [.blue,.teal]), startPoint: .top, endPoint: .center)
                
                VStack{
                    Spacer()
                    Text("Bienvendio!")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "sailboat.fill")
                            .resizable()
                            .frame(width: 75,height: 75)
                            .padding(.vertical, -5)
                            .padding(.horizontal, 10)
                        Spacer()
                    }
                    VStack(spacing: 20){
                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 50)
                        
                        SignInEmailView(showSignInView: $showSignInView)
                        
                        HStack{
                            Text("Already have an account?")
                            NavigationLink{
                                LogInEmail(showSignInView: $showSignInView)
                            } label: {
                                Text("Log In")
                                    .font(.headline)
                                    .underline()
                                
                            }
                        }
                        continueWithSection
                        
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height * 0.70)
//                    .background(Color.white)
//                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .background(colorScheme == .dark ? .black : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
            }
            .ignoresSafeArea()
            .ignoresSafeArea(.keyboard)
            .onTapGesture {
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
            }
        }
//        .fullScreenCover(isPresented: $showSetUpUser) {
//            SetUpUserView(showSetUpUser: $showSetUpUser, showSignInView: $showSignInView)
//        }
    }
}

extension AuthenticationView{
    
    private var continueWithSection: some View {
        
        
    
        
        Section{
            
            Text("Or continue with")
                .font(.headline)
                .foregroundStyle(Color.gray)
            
            //            SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
            //                .allowsHitTesting(false)
            //            .frame(width: UIScreen.main.bounds.width * 0.70, height: 55)
            
            Button(action:{
                Task{
                    do{
                        
                        try await viewModel.signInApple()
                        
                        showSignInView = false
                        
                    } catch{
                        print(error)
                    }
                }
            }, label:{
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
            })
            .frame(width: UIScreen.main.bounds.width * 0.70, height: 55)
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)){
                Task{
                    do{
                        try await viewModel.signInGoogle()
                       
                        showSignInView = false
                    } catch{
                        print(error)
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.70, height: 55)
        }
        
    }
}


#Preview {
    NavigationStack{
        AuthenticationView(showSignInView: .constant(true))
        
    }
}
