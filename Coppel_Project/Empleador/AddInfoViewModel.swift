//
//  AddInfoViewModel.swift
//  Coppel_Project
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine


final class AddInfoViewModel: ObservableObject{
    
    ///Access the shared instance using this variable
    static let shared = AddInfoViewModel()
    private let encoder = UserManager.shared.encoder
    
    private var db = Firestore.firestore().collection("users")

    private func userDocument(userId: String) -> DocumentReference{
        db.document(userId).collection("UserInfo").document(userId)
    }
    
    func addCardInfo(user: UserData) async throws {
        try userDocument(userId: user.user_id).setData(from: user, merge: false, encoder: encoder)
    }
    
    
    func addUserInfo(user: UserData) async throws {
        try userDocument(userId: user.user_id).setData(from: user, merge: false, encoder: encoder)
    }
    
    func getUserInfo(user: String) async throws -> UserData{
        let snapshot = try await userDocument(userId: user).getDocument()

        guard let data = snapshot.data(),
              let apellidos = data["apellidos"] as? String,
              let calle = data["calle"] as? String,
              let ciudad = data["ciudad"] as? String,
              let codigo_postal = data["codigo_postal"] as? String,
              let estado = data["estado"] as? String,
              let nombre = data["nombre"] as? String,
              let razon_social = data["razon_social"] as? String,
              let rfc = data["rfc"] as? String,
              let tipo_usuario = data["tipo_usuario"] as? String,
              let codigo_postal = data["codigo_postal"] as? String,
              let user_id = data["user_id"] as? String
        else{
            print("Error timed out")
            return UserData(user_id: "", nombre: "", apellidos: "", razonSocial: "", rfc: "", estado: "", ciudad: "", calle: "", codigoPostal: "", tipo_usuario: "")
        }
              
        return UserData(user_id: user_id, nombre: nombre, apellidos: apellidos, razonSocial: razon_social, rfc: rfc, estado: estado, ciudad: ciudad, calle: calle, codigoPostal: codigo_postal, tipo_usuario: tipo_usuario)
    }
    
    private func userInterests(userId: String) -> DocumentReference{
        db.document(userId).collection("Intereses").document(userId)
    }
    
    func addInterests(userId: String, interests: [String]) async throws{
        
        let data: [String: Any] = [
            "intereses": interests
        ]
        
        try await userInterests(userId: userId).setData(data)
        
        try userInterests(userId: userId).setData(from: interests, merge: false, encoder: encoder)
    }
}

//Tarjeta
extension AddInfoViewModel{
    private func userCard(userId: String) -> DocumentReference{
        db.document(userId).collection("Debit/Card").document(userId)
    }
}

