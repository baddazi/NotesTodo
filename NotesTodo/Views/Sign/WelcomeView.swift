import SwiftUI

struct WelcomeView: View {
  private enum SignType: Hashable {
    case logIn
    case signUp
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        VStack {
          Text("Sign with google")
          Text("Sign with apple")
          NavigationLink(value: SignType.logIn) {
            Text("Log In")
          }
          HStack {
            Text("Do not have a account?")
            NavigationLink(value: SignType.signUp) {
              Text("Sign up")
            }
          }
          
        }
        .padding(.top, 80)
        Spacer()
      }
      .navigationDestination(for: SignType.self) { value in
        switch value {
        case SignType.logIn: LoginView()
        case SignType.signUp: SignUpView()
        }
      }
      .padding()
      .navigationTitle("Welcome")
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}

