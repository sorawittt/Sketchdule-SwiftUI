import SwiftUI

struct SelectScheduleView: View {
    @State private var showingAlert = false
    @ObservedObject var selectSubjectVM = SelectSubjectViewModel.shared
    let db = DB()
    @State var updater = false
    
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
    
    @State var tempIndex = 0
    
    
    
    var body: some View {
        
        VStack {
//            NavigationLink(destination: MockTimetable(), tag: 1, selection: $action) {EmptyView()}
//            NavigationLink(destination: MockTimetable(), tag: 2, selection: $action) {EmptyView()}
            
            Form {
                Section {
                    
                    Picker(selection: $selectedIndex, label: Text("เลือกรูปแบบตารางเรียน").font(.system(size: 16))) {
                        ForEach(0..<selectSubjectVM.allCreateSchedule.count) { i in
                                HStack {
                                    Text("แบบที่ \(i + 1)")
                                    Button(action: {
                                        tempIndex = i
                                        showingDetail.toggle()
                                    }) {
                                        Image(systemName: "info.circle")
                                            .renderingMode(.template)
                                            .foregroundColor(Color(UIColor.systemBlue))
                                    }.sheet(isPresented: $showingDetail) {
                                        Timetable(data: selectSubjectVM.allCreateSchedule[tempIndex])
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
            
            .alert(isPresented:$showingAlert) {
                Alert(title: Text("กรุณาตรวจสอบความถูกต้อง"), message: Text("หากกดปุ่มยืนยันจะเป็นการแทนที่ตารางเรียนปัจจุบันด้วยตารางเรียนใหม่ คุณแน่ใจที่จะทำต่อ?"), primaryButton: .default(Text("ยืนยัน")) {
                    db.addSubject(subject: selectSubjectVM.allCreateSchedule[selectedIndex].subject)
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
    
    private func setTempIndex(i: Int) {
        tempIndex = i
    }
    
    private func refresh() {
        updater.toggle()
    }
}

struct SelectTimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        SelectScheduleView()
    }
}
