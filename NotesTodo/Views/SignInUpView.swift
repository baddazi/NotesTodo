import SwiftUI
import GoogleSignIn
import Firebase
import GoogleSignInSwift
import Introspect

struct SignInUpView: View {
  @Environment(\.[key: \Throw.self]) var `throw`
  @State private var uiViewController: UIViewController?
  @State private var isSignUp = false
  @State var email = "test@test.cz"
  @State var password = "12345678"
  @State var varifationPassword = ""
  @State var signType: SignTyp
  @State private var isEmailSignIn = false
  @State private var isGoogleSignIn = false
  
  enum SignTyp {
    case signIn
    case signUp
  }
  var body: some View {
    NavigationStack {
      VStack {
        VStack {
          // Sign with apple need to register the app on appleStoreConnect and I do not want that right know. Will see in the feature if I will change my mind.
          //Text("Sign with apple")
          emailSignIn
          Spacer()
          signButtons
          if signType == .signIn {
            missingAccount
          }
        }
        .padding()
        Spacer()
      }
      .padding()
      .navigationDestination(isPresented: $isSignUp) {
        SignInUpView(signType: .signUp)
      }
      .navigationTitle("Welcome to Notes")
      .introspectViewController(customize:  { uiViewController in
        Task { @MainActor in
          self.uiViewController = uiViewController
        }
      })
    }
  }
  
  private var emailSignIn: some View {
    VStack {
      Text(signType == .signIn ? "Please Sign in to your account" : "Fill your credentials to create a account")
      VStack(spacing: 5) {
        VStack(spacing: 15) {
          TextField("Email", text: $email)
            .keyboardType(.emailAddress)
            .textFieldStyle(SignInUpTextField())
          
          SecureField("Password", text: $password)
            .textFieldStyle(SignInUpTextField())
          
          if signType == .signUp {
            SecureField("Confirm Password", text: $varifationPassword)
              .textFieldStyle(SignInUpTextField())
          }
          
        }
        if signType == .signIn {
          HStack {
            Spacer()
            Button{ forgetPassword() } label: {
              Text("Forgot Password?")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          }
        }
      }
      .padding(.top, 60)
    }
    
  }

  
  private var signButtons: some View {
    VStack {
      Button {
        if signType == .signIn {
          signIn()
        } else {
          signUp()
        }
      } label: {
        if isEmailSignIn {
          ProgressView()
            .frame(maxWidth: .infinity)
        }
        else {
          Text(signType == .signIn ? "Sign in" : "Sign up")
            .frame(maxWidth: .infinity)
        }
      }
      .buttonStyle(SignInUpButton(background: .blue, foreground: .white))
      .disabled(isEmailSignIn)
      Button { googleSignIn() } label: {
        if isGoogleSignIn {
          ProgressView()
            .frame(maxWidth: .infinity)
        }
        else {
          HStack {
            Image("googleSignIn")
              .resizable()
              .frame(width: 50, height: 50)
              .scaledToFit()
            
            Text("Sign with google")
          }
          .frame(maxWidth: .infinity)
        }
      }
      .buttonStyle(SignInUpButton(background: Color("GoogleButton"), foreground: .black))
    }
  }
  
  private var missingAccount: some View {
    HStack {
      Text("Do not have a account?")
        .font(.caption)
      Button { isSignUp = true }
    label: {
      Text("Sign up")
        .font(.caption)
      }
    }
  }
  
  private func forgetPassword() {
    // TODO: !!!
    `throw`.try {
      throw SimpleError("This feature is not implemeted")
    }
  }
  
  private func signIn() {
    _ = `throw`.task {
      isEmailSignIn = true
      if password.isEmpty || email.isEmpty {
        isEmailSignIn = false
        throw SimpleError("Email and password need to be filled")
      }
      _ = try await Auth.auth().signIn(withEmail: email, password: password)
      isEmailSignIn = false
    }
  }
  
  
  private func signUp() {
    _ = `throw`.task {
      if password != varifationPassword {
        throw SimpleError("Passwords are different")
      }
      if password.isEmpty || email.isEmpty {
        throw SimpleError("Email and passwords need to be filled")
      }
      _ = try await Auth.auth().createUser(withEmail: email, password: password)
      
    }
  }
  
  
  private func googleSignIn() {
    let _ = `throw`.task { @MainActor in 
      guard let clientID = FirebaseApp.app()?.options.clientID,
            let uiViewController = uiViewController
      else { throw SimpleError("Unable to sign in")  }
      let config = GIDConfiguration(clientID: clientID)
      
      GIDSignIn.sharedInstance.configuration = config
      isGoogleSignIn = true
      let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: uiViewController)
      
      guard let idToken = gidSignInResult.user.idToken?.tokenString
      else { isGoogleSignIn = false; throw SimpleError("Unable to sign in") }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: gidSignInResult.user.accessToken.tokenString)
      
      try await Auth.auth().signIn(with: credential)
      isGoogleSignIn = false
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    SignInUpView(signType: .signIn)
  }
}
