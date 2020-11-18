import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            Spacer()
            BottomBar()
        }
    }
}

struct BottomBar : View {
    @ObservedObject private var selectSubject = SelectSubjectViewModel.shared
    @ObservedObject var userDB = UserDB.shared
    var body: some View {
        
        if userDB.isLogin {
            TabView {
                TodayScheduleView()
                    .tabItem{
                        Image(systemName: "calendar")
                        Text("ตารางเรียน")
                }
                
                CreateScheduleView(selectSubjectVM: selectSubject)
                    .tabItem{
                        Image(systemName: "calendar.badge.plus")
                        Text("สร้างตารางเรียน")
                }
                
                
                SettingView()
                    .tabItem{
                        Image(systemName: "ellipsis")
                        Text("ตั้งค่า")
                }
            }
            .font(.system(size: 22))
        } else  {
            Login()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
