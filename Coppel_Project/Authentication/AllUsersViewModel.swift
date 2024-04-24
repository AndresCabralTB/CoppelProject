//
//  AllUsersViewModel.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class AllUsersViewModel: ObservableObject{

    ///Set every user who has an account to this collection
    private var db = Firestore.firestore().collection("all_users")
    
    func userDocument() -> DocumentReference {
        db.document("ids")
    }
    
    func setUserID(userID: [String]) async throws{
        
        let data: [String: Any] = [
            "user_id": userID
        ]
        
        try await userDocument().setData(data)
    }
    
    func getUsers() async throws -> [String] {
        let snapshot = try await userDocument().getDocument()
        
        guard let data = snapshot.data(),
              let allUserArray = data["user_id"] as? [String]
        else{
            return []
        }
        return allUserArray
    }
    
    
}
