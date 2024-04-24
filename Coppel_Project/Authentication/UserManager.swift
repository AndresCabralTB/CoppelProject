//
//  UserManager.swift
//  LogInAuthentication
//
//  Created by Andres Cabral on 23/04/24.
//


//Keep track of all the user information
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable{
    let userID: String
    let email: String?
    let photoURL: String?
    
}

final class UserManager{
    static let shared = UserManager()
    private init(){}
    
    private let userCollection = Firestore.firestore().collection("users")

    private func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
        
    }
    
    public let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
        
    func createNewUser(user: DBUser) async throws{
        try userDocument(userId: user.userID).setData(from: user,merge: false, encoder: encoder)
        
    }
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func getUser(userID: String) async throws -> DBUser {
        let snapshot = try await userDocument(userId: userID).getDocument()
        
        guard let data = snapshot.data(),  let userID = data["user_id"] as? String, let email = data["email"] as? String
        else{
            print("Error getting DBUser")
            throw URLError(.badServerResponse)
        }
        let photoURL = data["photo_url"] as? String
        
        return DBUser(userID: userID, email: email, photoURL: photoURL)
    }
}
