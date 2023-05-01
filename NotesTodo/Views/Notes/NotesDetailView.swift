import SwiftUI

struct NotesDetailView: View {
  @State var id: UUID
  @State var date: Date
  @State var text: String
  var body: some View {
    VStack() {
      TextEditor(text: $text)
        .padding()      
      Spacer()
    }
  }
  
//  func convertToSingleText() -> String {
//    return title + "\n" + text
//  }
  
//  func convertFromSingleText(text: String) {
//    if let index = text.firstIndex(of: "\n"),
//       String(text.prefix(upTo: index)).count < 10 {
//     let title = String(text.prefix(upTo: index))
//    }
//
//    let title = String(text.prefix(10))
//  }
}

struct NotesDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NotesDetailView(id: .init(), date: .now, text: sampleText)
  }
}


extension NotesDetailView_Previews {
  static let sampleText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nunc auctor. Pellentesque sapien. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aliquam erat volutpat. Mauris tincidunt sem sed arcu. Integer tempor. Etiam commodo dui eget wisi. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Fusce tellus odio, dapibus id fermentum quis, suscipit id erat. Aliquam ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Aliquam ante. Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus, nec bibendum odio risus sit amet ante. Morbi leo mi, nonummy eget tristique non, rhoncus non leo. Praesent vitae arcu tempor neque lacinia pretium. Nulla accumsan, elit sit amet varius semper, nulla mauris mollis quam, tempor suscipit diam nulla vel leo. Mauris metus. Cras pede libero, dapibus nec, pretium sit amet, tempor quis. Integer pellentesque quam vel velit. Fusce nibh. Aliquam ornare wisi eu metus.Praesent in mauris eu tortor porttitor accumsan. Aliquam erat volutpat. Nulla non arcu lacinia neque faucibus fringilla. Etiam sapien elit, consequat eget, tristique non, venenatis quis, ante. Suspendisse nisl. Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed, est. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Mauris dictum facilisis augue. Aliquam ante. Sed ac dolor sit amet purus malesuada congue. Integer tempor. Nulla accumsan, elit sit amet varius semper, nulla mauris mollis quam, tempor suscipit diam nulla vel leo. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. In dapibus augue non sapien. Duis bibendum, lectus ut viverra rhoncus, dolor nunc faucibus libero, eget facilisis enim ipsum id lacus. Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus, nec bibendum odio risus sit amet ante."
}
