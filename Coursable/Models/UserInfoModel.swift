//
//  UserInfoModel.swift
//  Coursable
//
//  Created by Ari Reitman on 11/26/22.
//

import Foundation
import FirebaseFirestoreSwift

struct UserInfoModel: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var name: String
    var lastName: String
    
    
//    enum CodingKeys: String, CodingKey {
//      case id
//      case name
//      case lastName
//    }
    
    static let UserInfoModelExample = UserInfoModel(id: "1", userId: "123", name: "Ari", lastName: "Reitman")
}
