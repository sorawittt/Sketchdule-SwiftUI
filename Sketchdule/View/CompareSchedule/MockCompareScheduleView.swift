//
//  MockCompareScheduleView.swift
//  schedule
//
//  Created by Sorawit Ruangthong on 21/10/2563 BE.
//  Copyright © 2563 Sorawit Ruangthong. All rights reserved.
//

import SwiftUI
import ElliotableSwiftUI

struct MockCompareScheduleView: View {
    var body: some View {
            
            generateTimetableView()
            
        }
        
        private func generateTimetableView() -> ElliotableView {
            let courseList = [
                ElliottEvent(courseId: "1", courseName: "ไม่ว่าง 1", roomName: "", professor: "", courseDay: .monday, startTime: "06:00", endTime: "12:00", backgroundColor: UIColor.systemYellow),
                ElliottEvent(courseId: "2", courseName: "ไม่ว่าง 2", roomName: "", professor: "", courseDay: .monday, startTime: "13:30", endTime: "16:00", backgroundColor: .orange),
                ElliottEvent(courseId: "3", courseName: "ไม่ว่าง 3", roomName: "", professor: "PROF1", courseDay: .thursday, startTime: "12:00", endTime: "15:00", backgroundColor: UIColor.systemOrange),
                ElliottEvent(courseId: "4", courseName: "ไม่ว่าง 4", roomName: "", professor: "PROF4", courseDay: .tuesday, startTime: "14:30", endTime: "18:00", backgroundColor: UIColor.systemRed),
                ElliottEvent(courseId: "5", courseName: "ไม่ว่าง 5+", roomName: "", professor: "", courseDay: .wednesday, startTime: "10:30", endTime: "16:00", backgroundColor: .red),
                ElliottEvent(courseId: "1", courseName: "ไม่ว่าง 1", roomName: "", professor: "", courseDay: .friday, startTime: "13:00", endTime: "19:00", backgroundColor: UIColor.systemYellow)]
            let daySymbols = ["จ", "อ", "พ", "พฤ", "ศ", "ส"]
            let elliotableView = ElliotableView()
            
            elliotableView.courseList(list: courseList)
            elliotableView.dayCount(count: 6)
            elliotableView.daySymbols(symbols: daySymbols)
            elliotableView.borderColor(color: Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: 1))
            elliotableView.headerFont(font: .system(size: 14, weight: .bold))
            elliotableView.symbolBackgroundColor(color: Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97, opacity: 1))
            elliotableView.timeHeaderTextColor(color: Color(.sRGB, red: 0.6, green: 0.6, blue: 0.6, opacity: 1))
            
            return elliotableView
        }
}

struct MockCompareScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MockCompareScheduleView()
    }
}
