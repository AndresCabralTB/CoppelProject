//
//  Coppel_ProjectApp.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI
import FirebaseCore

struct UserData: Codable{
    var user_id: String
    var nombre: String = ""
    var apellidos: String = ""
    var razonSocial: String = ""
    var rfc: String = ""
    var estado: String = ""
    var ciudad: String = ""
    var calle: String = ""
    var codigoPostal: String = ""
    var tipo_usuario: String = ""
}

struct CardData: Codable{
    var user_id: String
    var nombre: String = ""
    var apellidos: String = ""
    var razonSocial: String = ""
    var rfc: String = ""
    var estado: String = ""
    var ciudad: String = ""
    var calle: String = ""
    var codigoPostal: String = ""
    var tipo_usuario: String = ""
}


@MainActor
final class UserInfo: ObservableObject{
    @Published var user: UserData = UserData(user_id: "", nombre: "", apellidos: "", razonSocial: "", rfc: "", estado: "", ciudad: "", calle: "", codigoPostal: "", tipo_usuario: "")
    
}

@MainActor
final class TagViewModel: ObservableObject{
    @Published var tag: Int = 0
}

@MainActor
final class StartUpTabViewModel: ObservableObject{
    @Published var startUpTag: Int = 0
}

@main
struct Coppel_ProjectApp: App {
    
    @StateObject var startUpTagViewModel = StartUpTabViewModel()
    @StateObject var tagViewModel = TagViewModel()
    @StateObject var userInfo = UserInfo()

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(tagViewModel)
                .environmentObject(userInfo)
                .environmentObject(startUpTagViewModel)
            
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
