//
//  AddSubjectViewModel.swift
//  Sketchdule
//
//  Created by Sorawit Ruangthong on 14/11/2563 BE.
//

import Foundation
import Combine

typealias Subjects = [Subject]

class AddSubjectViewModel: ObservableObject {
    @Published var allSubject = [Subject]()
    @Published var searchCode = ""
    @Published var filteredData: [Subject] = [Subject]()
    

    init() {
        guard let url = URL(string: "http://cnc.cs.sci.ku.ac.th:9900/subjects/code?code=0") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let subject = try! JSONDecoder().decode(Subjects.self, from: data)
            DispatchQueue.main.async {
                self.allSubject.append(contentsOf: subject)
            }
        }.resume()
        
    }
    
    func subjectMatchSeacrhCode() -> [Subject] {
        return allSubject.filter({
            searchCode.isEmpty ? true : $0.code.contains(searchCode)
        })
    }
}
