import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct YourApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @State private var errors: [Swift.Error] = []
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .showErrors()
  //      .autoSignIn()
 //     ContentView_Previews.previews
    }
  }
}

struct AutoSignIn :ViewModifier {
  @Environment(\.[key: \Throw.self]) var `throw`
  private let email = "test@test.cz"
  private let password = "12345678"
  
  func body(content: Content) -> some View {
    content
      .task {
        let _  = `throw`.task {
         let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        }
      }
  }
}

private extension View {
  func autoSignIn() -> some View {
    modifier(AutoSignIn())
  }
}


