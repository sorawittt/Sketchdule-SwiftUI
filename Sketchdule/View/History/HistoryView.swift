//
//  HistoryView.swift
//  Sketchdule
//
//  Created by Sorawit Ruangthong on 14/11/2563 BE.
//

import SwiftUI

struct HistoryView: View {
    
    var body: some View {
         NavigationView {
            Form {
                Section(header: Text("ปี 1")) {
                    NavigationLink(destination: TimetableView(name: "ปี 1 ภาคต้น")) {
                            Text("ภาคต้น").font(.system(size: 17))
                    }
                    NavigationLink(destination: TimetableView(name: "ปี 1 เทอมปลาย")) {
                            Text("ภาคปลาย").font(.system(size: 17))
                    }
                }
                
                Section(header: Text("ปี 2")) {
                    NavigationLink(destination: TimetableView(name: "ปี 2 ภาคต้น")) {
                            Text("ภาคต้น").font(.system(size: 17))
                    }
                    NavigationLink(destination: TimetableView(name: "ปี 2 เทอมปลาย")) {
                            Text("ภาคปลาย").font(.system(size: 17))
                    }
                }
                
                Section(header: Text("ปี 3")) {
                    NavigationLink(destination: TimetableView(name: "ปี 3 ภาคต้น")) {
                            Text("ภาคต้น").font(.system(size: 17))
                    }
                    NavigationLink(destination: TimetableView(name: "ปี 3 เทอมปลาย")) {
                            Text("ภาคปลาย").font(.system(size: 17))
                    }
                }
            }
            .navigationBarTitle("ตารางเรียนที่เคยสร้าง")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
