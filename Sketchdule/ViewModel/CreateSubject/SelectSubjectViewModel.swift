import Foundation
import Combine

class SelectSubjectViewModel: ObservableObject {
    @Published var selectSubject = [Subject]()
   
    private var cancellables = Set<AnyCancellable>()
    

    func addSubject(subject: Subject) {
        print("Adding: \(subject.name)")
        selectSubject.append(subject)
    }
    
    func removeSubject(c: String) {
        selectSubject = selectSubject.filter() {
            $0.code != c
        }
    }
    
    func isContain(c: String) -> Bool {
        for s in selectSubject {
            if s.code == c {
                return true
            }
        }
        return false
    }
    
    func getIndex(c: String) -> Int {
        guard let index = selectSubject.firstIndex(where: {
            $0.code == c
        }) else { return -1 }
        return index
    }
    
    func emptrySelectSubject() {
        selectSubject = [Subject]()
    }
    
}
