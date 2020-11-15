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
    var body: some View {
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
            
            
            HistoryView()
                .tabItem{
                    Image(systemName: "clock")
                    Text("ประวัติ")
            }
            
            Login()
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
