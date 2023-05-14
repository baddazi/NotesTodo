import Foundation
import SwiftUI
import FirebaseAuth

struct ContentView: View {
  @Environment(\.[key: \Throw.self]) var `throw`
  @State private var session: AuthStateDidChangeListenerHandle?
  @State private var user: User?
  var body: some View {
      Group {
        if let user = user {
          MainView()
            .environment(\.[key: \User.self], {
              FirebaseManager.userID = user.id
              return user
            }())
            .environment(\.[key: \FirebaseManager.self].fetchNotes, {
              return NotesTodo.samples
            })
            .environment(\.[key: \FirebaseManager.self].fetchNote, {_ in
              return NotesTodo.sample
            })
            .environment(\.[key: \FirebaseManager.self].updateNote, { note in
              print("update note ", note)
            })
            .environment(\.[key: \FirebaseManager.self].createNote, {
              return NotesTodo(id: "id", userID: user.id, text: "", date: .now)
            })
            .environment(\.[key: \FirebaseManager.self].deletNote, {note in
              print("delete note ", note)
            })
        } else {
          WelcomeView()
        }
      }
      .onAppear {
        listen()
      }
      .onDisappear {
        stopListeninig()
      }
  }
  
  func listen() {
    if let _ = session {
      return
    }
    user = Auth.auth().currentUser?.uid == nil ? nil : User(id: Auth.auth().currentUser!.uid)
    session = Auth.auth().addStateDidChangeListener{ auth, user in
      if user == nil {
        self.user = nil
      }
      else {
        self.user = User(id: user!.uid)
      }
    }
  }
  
  func stopListeninig() {
    if let _ = session {
      Auth.auth().removeStateDidChangeListener(session!)
    }
    session = nil
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .showErrors()
      .environment(\.[key: \User.self], {
        FirebaseManager.userID = User.sample.id
        return User.sample
      }())
      .environment(\.[key: \FirebaseManager.self].fetchNotes, {
        return NotesTodo.samples
      })
      .environment(\.[key: \FirebaseManager.self].fetchNote, {_ in
        return NotesTodo.sample
      })
      .environment(\.[key: \FirebaseManager.self].updateNote, { note in
        print("update note ", note)
      })
      .environment(\.[key: \FirebaseManager.self].createNote, {
        return NotesTodo(id: "id", userID: User.sample.id, text: "", date: .now)
      })
      .environment(\.[key: \FirebaseManager.self].deletNote, {note in
        print("delete note ", note)
      })
  }
}

