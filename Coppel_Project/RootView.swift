//
//  RootView.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct RootView: View {
    @State var showSignInView: Bool = false

    var body: some View {
        
        ZStack{
            //Deactivate the full screen cover and show the profile view when the user is authenticated
            if !showSignInView{
                NavigationStack{
                    HomeView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        //This full screen cover shows the authentication options (Email, Google, Apple)
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                AuthenticationView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    RootView()
}
