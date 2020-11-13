//
//  MockTimetable.swift
//  Sketchdule
//
//  Created by Sorawit Ruangthong on 14/11/2563 BE.
//

import SwiftUI
import ElliotableSwiftUI
import ToastUI

struct MockTimetable: View {
    @State var showingPopup = false
    let name = "แบบที่ 2"
    
    let data = Mocktable()
    var body: some View {
        VStack {
            HStack {
                Text("\(name)").font(.system(size: 20, weight: .bold))
                Button(action: {
                    showingPopup = true
                }) {
                    Image(systemName: "exclamationmark.circle").renderingMode(.template).foregroundColor(Color(UIColor.systemBlue))
                }
            }.padding(20)
            generateTimetableView()
        }.toast(isPresented: $showingPopup) {
                ToastView {
                    VStack {
                        ForEach(0..<data.elliotableVM.uniqueList.count) { c in
                            HStack {
                                Circle()
                                    .fill(Color(data.elliotableVM.uniqueList[c].backgroundColor))
                                    .frame(width: 15, height: 15)
                                Text("\(data.elliotableVM.uniqueList[c].courseName) (\(data.elliotableVM.uniqueList[c].roomName))").font(.system(size: 15))
                            }
                        }
                        Button {
                            showingPopup = false
                        } label: {
                            Text("OK")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.vertical, 10.0)
                                .background(Color.accentColor)
                                .cornerRadius(8.0)
                        }
                    }
                }
            }
    }
        
        private func generateTimetableView() -> ElliotableView {
            
            let mockData = Mocktable()
            
            let daySymbols = ["จ", "อ", "พ", "พฤ", "ศ", "ส", "อา"]
            let elliotableView = ElliotableView()
            
            elliotableView.courseList(list: mockData.elliotableVM.courseList)
            elliotableView.dayCount(count: 6)
            elliotableView.daySymbols(symbols: daySymbols)
            elliotableView.borderColor(color: Color(.sRGB, red: 0.7, green: 0.7, blue: 0.7, opacity: 1))
            elliotableView.headerFont(font: .system(size: 14, weight: .bold))
            elliotableView.symbolBackgroundColor(color: Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97, opacity: 1))
            elliotableView.timeHeaderTextColor(color: Color(.sRGB, red: 0.6, green: 0.6, blue: 0.6, opacity: 1))
        
            
            return elliotableView
        }
}

struct MockTimetable2View_Previews: PreviewProvider {
    static var previews: some View {
        MockTimetable()
    }
}
