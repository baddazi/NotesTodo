import SwiftUI
import FirebaseAuth

struct MainView: View {
  @Environment(\.[key: \Throw.self]) var `throw`
  @Environment(\.[key: \FirebaseManager.self]) var firebaseManager
  @State private var search: String = ""
  @FocusState private var focusedField: Field?
  @State private var notes: [NotesTodo] = []
  @State private var isLoading = true
  @State private var isCreatingNote = false
  @State private var newNote: NotesTodo? = nil
  
  enum Field: Hashable {
    case search
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        ZStack {
          ScrollView {
            searchField
            notesItems
              .redacted(reason: isLoading ? .placeholder : .init())
          }
          VStack {
            Spacer()
            Button{ createNote() } label: {
              if isCreatingNote {
                ProgressView()
              }
              else {
                Image(systemName: "square.and.pencil")
              }
            }
            .disabled(isCreatingNote)
          }
        }
      }
      .task {
        let _ = `throw`.task {
          notes = try await firebaseManager.fetchNotes()
          isLoading = false
        }
      }
      .navigationDestination(for: NotesTodo.self) { note in
        NotesDetailView(note: note)
      }
      .navigationDestination(isPresented: Binding<Bool> {
        newNote != nil
      } set: { newValue in
        if !newValue {
          newNote = nil
        }
      }) {
        NotesDetailView(note: newNote ?? NotesTodo.sample)
      }
      .navigationTitle("Notes")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            Button("Sign out", action: signOut)
            Button("Test errors", action: testError)
          } label: {
            Image(systemName: "ellipsis.circle")
          }
        }
      }
      .padding()
    }
  }
  
  @ViewBuilder
  var notesItems: some View {
    Group {
      if notes.isEmpty {
        Text("No notes")
      }
      else {
        individualNotes
      }
    }
    .background(
      Color("ItemBackground")
        .cornerRadius(10)
    )
  }
  
  @ViewBuilder
  var individualNotes: some View {
    let filteredValues = search.count == 0 ? notes : notes.filter{ $0.text.contains(search) }
    
    VStack(spacing: 0) {
      ForEach(Array(filteredValues.enumerated()), id: \.1) { index, note in
        NavigationLink(value: note) {
          NotesItemView(note: note)
        }
        .foregroundColor(Color.black)
        if index != notes.count - 1 {
          Divider()
        }
      }
    }
  }
  
  var searchField: some View {
    ZStack {
      TextField("Search", text: $search)
        .padding(.leading, 25)
        .focused($focusedField, equals: .search)
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundColor(Color("MagnifyingGlass"))
          .onTapGesture {
            focusedField = .search
          }
        Spacer()
      }
    }
    .padding(5)
    .background(
      Color("ItemBackground")
        .cornerRadius(10))
  }
  
  func signOut() {
    `throw`.try {
      try Auth.auth().signOut()
    }
  }
  
  func testError() {
    `throw`.try {
      throw SimpleError(errorDescription: "Test1")
    }
    `throw`.try {
      throw SimpleError(errorDescription: "Test2")
    }
    `throw`.try {
      throw SimpleError(errorDescription: "Test3")
    }
    `throw`.try {
      throw SimpleError(errorDescription: "Test4")
    }
  }
  
  private func createNote() {
    let _  = `throw`.task {
      isCreatingNote = true
      defer {
        isCreatingNote = false
      }
     let note = try await firebaseManager.createNote()
      notes.append(note)
      newNote = note      
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
