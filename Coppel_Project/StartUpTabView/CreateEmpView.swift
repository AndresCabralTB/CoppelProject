//
//  CreateEmpView.swift
//  Coppel_Project
//
//  Created by Omar Atriano on 23/04/24.
//

import SwiftUI



struct CreateEmpView: View {
    
    @EnvironmentObject var startUpTag: StartUpTabViewModel
    @EnvironmentObject var userInfo: UserInfo
    @StateObject var authenticationManager = AuthenticationManager()
    @StateObject var addInfoViewModel = AddInfoViewModel()
    
    @State private var selection = 0
    public var priorityList = ["Empleado", "Empleador"]

    
    @State var empleado: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Bienvenido")
                    .font( .title)
                    .fontWeight(.bold)
                ScrollView {
                    LazyVStack {
                        
                        UpperInputTextView(title: "Logo")
                        HStack{
                            Text("Ingrese el logo de la compañía")
                            Spacer()
                            Button{
                                
                            } label: {
                                Image(systemName: "camera")
                                    .foregroundColor(.black)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 1))
                            }
                            
                        }
                        .padding(.horizontal,20)
                        
                        UpperInputTextView(title: "Identificación")
                        HStack{
                            Text("Tome una foto de su INE")
                            Spacer()
                            Button{
                                
                            } label: {
                                Image(systemName: "camera")
                                    .foregroundColor(.black)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .background(RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 1))
                            }
                            
                        }
                        .padding(.horizontal,20)
                        
                        
                        InputTextView(text: $userInfo.user.nombre, title: "Nombre", placeholder: "Nombre")
                        InputTextView(text: $userInfo.user.apellidos, title: "Apellidos", placeholder: "Apellidos")
                        InputTextView(text: $userInfo.user.razonSocial, title: "Razón social", placeholder: "Razón social")
                        InputTextView(text: $userInfo.user.rfc, title: "RFC", placeholder: "RFC")
                        InputTextView(text: $userInfo.user.estado, title: "Estado", placeholder: "Estado")
                        InputTextView(text: $userInfo.user.ciudad, title: "Ciudad", placeholder: "Ciudad")
                        InputTextView(text: $userInfo.user.calle, title: "Calle", placeholder: "Calle")
                        InputTextView(text: $userInfo.user.codigoPostal, title: "Código postal", placeholder: "Código postal")
                        UpperInputTextView(title: "Tipo de usuario")
                        
                        InputTextView(text: $userInfo.user.tipo_usuario, title: "Tipo de usuario", placeholder: "Tipo de usuario")
                        
                        Picker("Tipo de Usuario",selection: $selection){
                            ForEach(0..<3, id:\.self){ index in
                                Text("Priority \(index + 1)")
                            }
                        }.pickerStyle(.menu)
                        
                    }
                }
                
                Button{
                    Task{
                        do{
                            userInfo.user.user_id = try authenticationManager.getAuthenticatedUser().uid
                            try await addInfoViewModel.addUserInfo(user: userInfo.user)
                            
                        }
                        if userInfo.user.tipo_usuario == "Empleado"{
                            startUpTag.startUpTag = 1
                        } else if userInfo.user.tipo_usuario == "Empleador" {
                            startUpTag.startUpTag = 1
                        }
                        
                    }
                } label: {
                    Text("Registrar")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .padding(.vertical)
                        .background(RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 1).fill(Color.coppelBlue))
                }
                
            }
            .padding(.vertical, 20)
        }
        
    }
}

//#Preview {
//    CreateEmpView()
//}
