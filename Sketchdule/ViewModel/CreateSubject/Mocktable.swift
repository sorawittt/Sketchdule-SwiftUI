//
//  Mocktable.swift
//  Sketchdule
//
//  Created by Sorawit Ruangthong on 14/11/2563 BE.
//

import Foundation

struct Mocktable {
    var elliotableVM = ElliotableViewModel()
    
    let os1 = ElliotableModel(id: "01418331", name: "Operating Systems", day: 1, startTime: "14:30", endTime: "16:30", sec: "2", room: "Online")
    let os2 = ElliotableModel(id: "01418331", name: "Operating Systems", day: 3, startTime: "14:30", endTime: "16:30", sec: "2", room: "Online")
    let db1 = ElliotableModel(id: "01418221", name: "Fundamentals of Database Systems", day: 2, startTime: "09:00", endTime: "11:00", sec: "2", room: "Online")
    let db2 = ElliotableModel(id: "01418221", name: "Fundamentals of Database Systems", day: 5, startTime: "09:00", endTime: "11:00", sec: "2", room: "Online")
    let eng = ElliotableModel(id: "01355202", name: "Fundamental English Writing", day: 1, startTime: "10:00", endTime: "12:00", sec: "2", room: "Online")
    
    init() {
        elliotableVM.addCourse(elliotable: os1)
        elliotableVM.addCourse(elliotable: os2)
        elliotableVM.addCourse(elliotable: db1)
        elliotableVM.addCourse(elliotable: db2)
        elliotableVM.addCourse(elliotable: eng)
    }
}
