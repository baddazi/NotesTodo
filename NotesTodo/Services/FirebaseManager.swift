import Firebase
import FirebaseAuth
import Combine
import FirebaseFirestoreSwift
import SwiftUI

struct FirebaseManager {
  private static let ref = Firestore.firestore()
  static var userID: User.ID = ""

  var fetchNotes :() async throws -> [NotesTodo] = {
    let data = try await ref.collection("notes").getDocuments()
    var notes: [NotesTodo] = []
    
    try data.documents.forEach { rawNote in
      let note = try rawNote.data(as: NotesTodo.self)
      notes.append(note)
    }
    
    return notes.filter({ $0.id == userID })
  }
  
  var fetchNote: (NotesTodo.ID) async throws -> NotesTodo = { id in
    guard let id = id,
    let rawNote = try await ref.collection("notes").getDocuments().documents.first(where: { try $0.data(as: NotesTodo.self).id == id })
    else { throw SimpleError("Unable to fetch note") }
    
    return try rawNote.data(as: NotesTodo.self)
  }
  
  var updateNote: (NotesTodo) throws -> Void = { note in
    guard let id = note.id,
          note.userID == userID
    else { throw SimpleError("Unable to update note")}
    try ref.collection("notes").document(id).setData(from: note)
  }
  
  var createNote: () async throws -> NotesTodo  = {
    let note = try ref.collection("notes").addDocument(from: NotesTodo(userID: userID, text: "", date: .now))
    // Thanks to that the firebase create id for note.
    return try await note.getDocument(as: NotesTodo.self)
  }
  
  var deletNote: (NotesTodo) throws -> Void = { notes in
    guard let id = notes.id,
          notes.userID == userID
    else { throw SimpleError("Unable to delete not") }
    ref.collection("notes").document(id).delete()
  }
}

extension FirebaseManager: EnvironmentKey {
  static var defaultValue = FirebaseManager()
}

