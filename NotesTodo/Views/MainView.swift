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
      notesList
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
          Button { createNote() } label: {
            if isCreatingNote {
              ProgressView()
            }
            else {
              Image(systemName: "square.and.pencil")
            }
          }
          .disabled(isCreatingNote)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu {
            Button("Sign out", action: signOut)
            Button("Test errors", action: testError)
          } label: {
            Image(systemName: "ellipsis.circle")
          }
        }
      }
    }
  }
  
  @ViewBuilder
  var notesList: some View {
    let filteredNotes = search.count == 0 ? notes : notes.filter{ $0.text.includeCaseInsesitive(search) }
      List {
        Section(header: EmptyView(), footer: EmptyView()) {
          searchField
            .listRowInsets(EdgeInsets())
        }
        .listRowBackground(
          RoundedRectangle(cornerRadius: 0)
            .fill(Color.clear)
        )
        if !isLoading {
          listItems(filteredNotes: filteredNotes)
        }
      }
      .overlay {
        if isLoading || filteredNotes.isEmpty {
          edgeCases
        }
      }
  }
  
  @ViewBuilder
  var edgeCases: some View {
    if isLoading {
     ProgressView()
    } else if notes.isEmpty {
      Text("Notes are empty")
    } else {
      Text("No search results")
    }
  }
  
  @ViewBuilder
  func listItems(filteredNotes: [NotesTodo]) -> some View {
    let filteredAndSortedNotes = filteredNotes.sorted(by: { $0.date > $1.date })
    ForEach(filteredAndSortedNotes) { note in
      NavigationLink(value: note) {
        NotesItemView(note: note)
      }
    }
    .onDelete(perform: delete)
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
  
  private func delete(at offsets: IndexSet) {
    `throw`.try {
      guard let index = offsets.first else { throw SimpleError("Unable to delete note")}
      try firebaseManager.deletNote(notes[index])
      notes.remove(atOffsets: offsets)
    }
  }
  
  private func createNote() {
    let _  = `throw`.task {
      isCreatingNote = true
      defer {
        isCreatingNote = false
      }
      let note = try await firebaseManager.createNote()
      newNote = note
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
