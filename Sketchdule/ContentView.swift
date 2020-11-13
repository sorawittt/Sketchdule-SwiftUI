import SwiftUI

struct ContentView: View {
    @EnvironmentObject var selectSubject: SelectSubjectViewModel
    var body: some View {
        VStack {
            Spacer()
            BottomBar()
        }
    }
}

struct BottomBar : View {
    @EnvironmentObject var selectSubject: SelectSubjectViewModel
    var body: some View {
        TabView {
            TodayScheduleView().environmentObject(selectSubject)
                .tabItem{
                    Image(systemName: "calendar")
                    Text("ตารางเรียน")
            }
            
            CreateScheduleView().environmentObject(selectSubject)
                .tabItem{
                    Image(systemName: "calendar.badge.plus")
                    Text("สร้างตารางเรียน")
            }
            
            
//            HistoryView()
                .tabItem{
                    Image(systemName: "clock")
                    Text("ประวัติ")
            }
            
//            SettingView()
                .tabItem{
                    Image(systemName: "ellipsis")
                    Text("ตั้งค่า")
            }
        }
        .font(.system(size: 22))
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
