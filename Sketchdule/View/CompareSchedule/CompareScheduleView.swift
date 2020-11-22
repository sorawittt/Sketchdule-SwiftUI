import SwiftUI

struct CompareScheduleView: View {
    @State var username = ""
    @State var showResult = false
    @State var isUserContain = false
    
    @ObservedObject var compareVM = CompareScheduleViewModel.shared
    
    @State var currentUser = UserDetail(firstname: "", lastname: "-", studentId: "-", id: "-")
    
    
    var body: some View {
        NavigationView {
                Form {
                    Section(header: Text("ค้นหาผู้ใช้")) {
                        HStack {
                            TextField("Username ของผู้ใช้", text: $username).font(.system(size: 17))
                            if (username.count >= 4) {
                                Button(action: {
                                    currentUser = compareVM.searchUser(u: username)
                                    if (currentUser.firstname != "") {
                                        showResult = true
                                        isUserContain = compareVM.isContain(userId: username)
                                    } else {
                                        showResult = false
                                    }
                                }) {
                                    Image(systemName: "magnifyingglass.circle.fill")
                                }
                            }
                        }
                        HStack {
                            Text("ผลการค้นหา").font(.system(size: 17))
                            Spacer()
                            Text("\(currentUser.firstname) \(currentUser.lastname)").font(.system(size: 17)).foregroundColor(Color(UIColor.systemGray))
                            if (showResult) {
                                if !(compareVM.isContain(userId: currentUser.id)) {
                                    Image(systemName: "plus.circle.fill").renderingMode(.template).foregroundColor(Color(UIColor.systemBlue)).onTapGesture {
                                        compareVM.addUser(user: currentUser)
                                    }
                                } else {
                                    Image(systemName: "minus.circle.fill").renderingMode(.template).foregroundColor(Color(UIColor.systemRed)).onTapGesture {
                                        compareVM.removeUser(user: currentUser)
                                    }
                                }
                            }
                        }
                    }
                    if (compareVM.userList.count > 0) {
                        Section(header: Text("รายชื่อผู้ใช้ที่ต้องการเปรียบเทียบ")) {
                            List {
                                ForEach(compareVM.userList) { i in
                                    Text("\(i.studentId) \(i.firstname) \(i.lastname)").font(.system(size: 17))
                                }
                            }
                        }
                        Section {
                            NavigationLink(destination: ShowCompareScheduleView()) {
                                    Text("เปรียบเทียบ").foregroundColor(Color(UIColor.systemBlue))
                                        .font(.system(size: 17))
                                }
                        }
                    }
                }
                .navigationBarTitle("เปรียบเทียบตารางเรียน")
                .onAppear() {
                    compareVM.reset()
                }
        }
    }
}

struct CompareScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        CompareScheduleView()
    }
}
