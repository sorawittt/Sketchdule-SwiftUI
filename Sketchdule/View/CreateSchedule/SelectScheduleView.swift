//
//  SelectScheduleView.swift
//  Sketchdule
//
//  Created by Sorawit Ruangthong on 14/11/2563 BE.
//

import SwiftUI

struct SelectScheduleView: View {
    @State private var showingAlert = false
    @ObservedObject var selectSubjectVM = SelectSubjectViewModel.shared
    let db = DB()
    
    let timetable = ["แบบที่ 1", "แบบที่ 2"]
    @State private var selectedIndex = 0
    @State private var action: Int? = 0
    @State private var currecntIndex = 0
    
    @State private var selectedYearIndex = 0
    var years = ["เลือกชั้นปี","1", "2", "3", "4", "5", "6", "7", "8"]
    
    @State private var selectedSemesterIndex = 0
    var semester = ["เลือกภาคเรียน","ภาคต้น", "ภาคปลาย"]
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingDetail = false
    
    
    var body: some View {
        
        VStack {
            NavigationLink(destination: MockTimetable(), tag: 1, selection: $action) {EmptyView()}
            NavigationLink(destination: MockTimetable(), tag: 2, selection: $action) {EmptyView()}
            
            Form {
                Section {
                    
                    Picker(selection: $selectedYearIndex, label: Text("ชั้นปีที่").font(.system(size: 16))) {
                        ForEach(0 ..< years.count) { i in
                            Text(years[i])
                        }.font(.system(size: 16))
                    }
                        
                    Picker(selection: $selectedSemesterIndex, label: Text("ภาคเรียน").font(.system(size: 16))) {
                        ForEach(0 ..< semester.count) { i in
                            Text(semester[i])
                        }
                    }.font(.system(size: 16))
                    
                    Picker(selection: $selectedIndex, label: Text("เลือกรูปแบบตารางเรียน").font(.system(size: 16))) {
                        ForEach(0 ..< timetable.count) { i in
                                HStack {
                                    
                                    Text(timetable[i])
                                    Button(action: {
                                        showingDetail.toggle()
                                    }) {
                                        Image(systemName: "info.circle")
                                            .renderingMode(.template)
                                            .foregroundColor(Color(UIColor.systemBlue))
                                    }.sheet(isPresented: $showingDetail) {
                                        MockTimetable()
                                    }
                                }
                            }
                        }.font(.system(size: 16))
                    }
                }
            Button(action: {
                showingAlert = true
            }) {
                Text("เสร็จสิ้น").font(.system(size: 15)).foregroundColor(.white)
                    .frame(minWidth: 330, maxWidth: 330, minHeight: 25, maxHeight: 25)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(!(checkButton()))
            .alert(isPresented:$showingAlert) {
                Alert(title: Text("กรุณาตรวจสอบความถูกต้อง"), message: Text("หากกดปุ่มยืนยันจะเป็นการแทนที่ตารางเรียนปัจจุบันด้วยตารางเรียนใหม่ คุณแน่ใจที่จะทำต่อ?"), primaryButton: .default(Text("ยืนยัน")) {
                    db.addSubject(subject: Mocktable().elliotableVM)
                        presentationMode.wrappedValue.dismiss()
                }, secondaryButton: .cancel(Text("ยกเลิก")))
            }
        }
           .navigationBarTitle("เลือกตารางเรียน")
    }
    
    private func checkButton() -> Bool {
        if ((selectedYearIndex != 0 ) && (selectedSemesterIndex != 0)) {
            return true
        }
        return false
    }
}

struct SelectTimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        SelectScheduleView()
    }
}
