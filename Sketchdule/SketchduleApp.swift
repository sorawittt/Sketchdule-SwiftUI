import SwiftUI

@main
struct SketchduleApp: App {
    @StateObject private var selectSubject = SelectSubjectViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(selectSubject)
        }
    }
}
