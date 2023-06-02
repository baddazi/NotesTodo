extension String {
  func separateTitle() -> String {
    let titleCount = 20
    if let index = self.firstIndex(of: "\n"),
       String(self.prefix(upTo: index)).count < titleCount {
      return String(self.prefix(upTo: index))
    }
    
    var title = String(self.prefix(titleCount))
    if self.count > 20 {
      title += "..."
    }
    
    return title
  }
  
  func includeCaseInsesitive(_ secondValue: String) -> Bool {
    let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
    guard let _ = self.range(of: secondValue, options: options) else { return false }
    return true
  }
}
