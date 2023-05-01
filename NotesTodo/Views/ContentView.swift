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
            .environment(\.[key: \User.self], user)
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
  }
}

