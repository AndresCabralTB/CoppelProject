//
//  StartUpView.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI

struct StartUpView: View {
    @EnvironmentObject var userInfo: UserInfo
    @EnvironmentObject var setUpUserTag: StartUpTabViewModel
    
    @Binding var showStartUp: Bool
    
    @State var addInfo = AddInfoViewModel()
    @State var authenticationManager = AuthenticationManager()
    
    @State var showIntereses: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
//            Text("Bienvenido")
//                .font( .title)
//                .fontWeight(.bold)
            
            Text("¿Tienes Cuenta Bancaria?")
                .font(.title2)
                .fontWeight(.bold)
            
            HStack{
                Button{
                    showIntereses = true
//                    showStartUp = false
                } label:{
                    Text("Si")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.coppelBlue))
                }
                
                Button{
                    setUpUserTag.startUpTag = 2
                } label:{
                    Text("No")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.10)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.coppelYellow))
                }
            }
            
            Text("Soy empleador")
        }
        .onAppear{
            Task{
                do{
                    userInfo.user = try await addInfo.getUserInfo(user: try authenticationManager.getAuthenticatedUser().uid)
                    
                    if userInfo.user.tipo_usuario == "Empleado"{
                        showIntereses = true
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showIntereses, onDismiss: {
            setUpUserTag.startUpTag = 2
        }) {
            InterestsView(showIntereses: $showIntereses)
        }
    }
}

//#Preview {
//    StartUpView()
//}
