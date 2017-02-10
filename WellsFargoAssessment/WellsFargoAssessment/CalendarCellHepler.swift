//
//  File.swift
//  WellsFargoAssessment
//
//  Created by Zhuoyu Li on 2/9/17.
//  Copyright © 2017 Joe. All rights reserved.
//

import Foundation

class CalendarCellData {
    var weekday: String
    var dayNumber: String
    
    init(weekday: String, dayNumber: String) {
        self.weekday = weekday
        self.dayNumber = dayNumber
    }
}


class CalendarCellHepler {
    func getCurrentMonthDayAndWeekday() -> (Int, Int) {
        let calendar = Calendar.current
        let date = Date()
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: date)))
        let range = calendar.range(of: .day, in: .month, for: startOfMonth!)
        let weekday = calendar.component(.weekday, from: startOfMonth!)
        return (range!.count, weekday)
    }
    
    func prepareCalendarCellData(startDate: (Int, Int)) -> [CalendarCellData] {
        var calendarCellData = [CalendarCellData]()
        for i in 0..<startDate.0 {
            let weekDay = getWeekDayString(weekday: WEEEDAY(rawValue: (startDate.1 + i) % 7)!)
            let day = getDayString(day: i + 1)
            calendarCellData.append(CalendarCellData(weekday: weekDay, dayNumber: day))
        }
        return calendarCellData
    }
    
    func getCurrentMonth() -> String {
        let currentMonth = Calendar.current.component(.month, from: Date())
        return getCurrentMonthString(currentMonth: currentMonth)
    }
    
    private func getCurrentMonthString(currentMonth: Int) -> String {
        switch currentMonth {
        case 1:
            return "JANUARY"
        case 2:
            return "FEBRURAY"
        case 3:
            return "MARCH"
        case 4:
            return "APRIL"
        case 5:
            return "MAY"
        case 6:
            return "JUNE"
        case 7:
            return "JULY"
        case 8:
            return "AUGUEST"
        case 9:
            return "SEPTEMBER"
        case 10:
            return "OCTOBER"
        case 11:
            return "NOVEMBER"
        case 12:
            return "DECEMBER"
        default:
            break
        }
        return ""
    }
    
    private func getWeekDayString(weekday: WEEEDAY) -> String{
        switch weekday {
        case .SUN:
            return "SUN"
        case .MON:
            return "MON"
        case .TUE:
            return "TUE"
        case .WED:
            return "WED"
        case .THU:
            return "THU"
        case .FRI:
            return "FRI"
        case .SAT:
            return "SAT"
        }
    }
    
    private func getDayString(day: Int) -> String {
        if day < 10 {
            return "0\(day)"
        }
        return "\(day)"
    }
}

enum WEEEDAY: Int {
    case SUN = 1
    case MON = 2
    case TUE = 3
    case WED = 4
    case THU = 5
    case FRI = 6
    case SAT = 0
}

