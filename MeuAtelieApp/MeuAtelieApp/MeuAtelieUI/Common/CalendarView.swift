//
//  CalendarView.swift
//  MeuAtelieApp
//
//  Created by Ana Júlia Volpi on 10/09/23.
//

/// https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec?permalink_comment_id=3737649#gistcomment-3737649
/// I've made some changes but the main idea behind this code belongs to basememara

import SwiftUI

struct CalendarView: View {
    private let calendar: Calendar
    private let monthYearFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter
    
    @Binding var selectedDate: Date
    var dates: [(date: Date, status: OrderStatus)]
    private static var now = Date() // Cache now
    
    init(calendar: Calendar, selectedDate: Binding<Date>, dates: [(date: Date, status: OrderStatus)]) {
        self.calendar = calendar
        self._selectedDate = selectedDate
        self.dates = dates
        self.monthYearFormatter = DateFormatter(dateFormat: "MMMM yyyy", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
        self.fullFormatter = DateFormatter(dateFormat: "MMMM dd, yyyy", calendar: calendar)
    }
    
    var body: some View {
        VStack {
//            Text("Selected date: \(fullFormatter.string(from: selectedDate))")
//                .bold()
//                .foregroundColor(.red)
            CalendarViewOptions(
                calendar: calendar,
                date: $selectedDate,
                content: { date in
                    ZStack {
                        Button(action: {
                            selectedDate = date
    //                        print("selected date: \(selectedDate)")
                        }) {
                            Text("00")
                                .padding(8)
                                .foregroundColor(.clear)
                                .background(
                                    Group {
                                        if calendar.isDate(date, inSameDayAs: selectedDate) {
                                            Color.MAColors.MAPinkLight
                                        }
    
//                                        if calendar.isDateInToday(date) {
//                                            Color.MAColors.MAPinkLight
//                                        }
    
                                        if let order = hasOrderIn(date: date) {
                                            if order.status == .completed {
                                                Color.green
                                            } else {
                                                if order.date < CalendarView.now {
                                                    Color.MAColors.MAWinePink
                                                } else {
                                                    Color.MAColors.MAPinkMediumLight
                                                }
                                            }
                                        }
                                    }
                                )
                                .cornerRadius(8)
                                .accessibilityHidden(true)
                                .overlay(
                                    Text(dayFormatter.string(from: date))
                                        .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? .white : .black)
                                )
                        }
                    }
                },
                trailing: { date in
                    Text(dayFormatter.string(from: date))
                        .foregroundColor(.secondary)
                },
                header: { date in
                    Text(weekDayFormatter.string(from: date))
                },
                title: { date in
                    HStack {
                        Text(monthYearFormatter.string(from: date))
                            .font(.headline)
                            .padding()
                        
                        Spacer()
                        
                        Button("hoje") {
                            selectedDate = .now
                        }
                        
                        Button {
//                            withAnimation {
                                guard let newDate = calendar.date(
                                    byAdding: .month,
                                    value: -1,
                                    to: selectedDate
                                ) else {
                                    return
                                }
                                
                                selectedDate = newDate
//                            }
                        } label: {
                            Label(
                                title: { Text("Previous") },
                                icon: { Image(systemName: "chevron.left") }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity)
                        }
                        Button {
//                            withAnimation {
                                guard let newDate = calendar.date(
                                    byAdding: .month,
                                    value: 1,
                                    to: selectedDate
                                ) else {
                                    return
                                }
                                
                                selectedDate = newDate
//                            }
                        } label: {
                            Label(
                                title: { Text("Next") },
                                icon: { Image(systemName: "chevron.right") }
                            )
                            .labelStyle(IconOnlyLabelStyle())
                            .padding(.horizontal)
                            .frame(maxHeight: .infinity)
                        }
                    }
                    .padding(.bottom, 6)
                }
            )
            .equatable()
        }
        .padding()
    }
    
    private func hasOrderIn(date: Date) -> (date: Date, status: OrderStatus)? {
        let hasOrder = dates.first(where: { calendar.isDate(date, inSameDayAs: $0.date) })
        return hasOrder
    }
}

// MARK: - Component

public struct CalendarViewOptions<Day: View, Header: View, Title: View, Trailing: View>: View {
    // Injected dependencies
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let trailing: (Date) -> Trailing
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    
    // Constants
    private let daysInWeek = 7
    
    public init(
        calendar: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder trailing: @escaping (Date) -> Trailing,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.trailing = trailing
        self.header = header
        self.title = title
    }
    
    public var body: some View {
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: daysInWeek)) {
            Section(header: title(month)) {
                ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                ForEach(days, id: \.self) { date in
                    if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                        content(date)
                    } else {
                        trailing(date)
                    }
                }
            }
        }
    }
}

// MARK: - Conformances

extension CalendarViewOptions: Equatable {
    public static func == (lhs: CalendarViewOptions<Day, Header, Title, Trailing>, rhs: CalendarViewOptions<Day, Header, Title, Trailing>) -> Bool {
        lhs.calendar == rhs.calendar && lhs.date == rhs.date
    }
}

// MARK: - Helpers

private extension CalendarViewOptions {
    func makeDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }
        
        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}

private extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]
        
        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }
            
            guard date < dateInterval.end else {
                stop = true
                return
            }
            
            dates.append(date)
        }
        
        return dates
    }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
            matching: dateComponents([.hour, .minute, .second], from: dateInterval.start)
        )
    }
}

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

// MARK: - Previews
#if DEBUG
struct CalendarView_Previews: PreviewProvider {
    
    struct GregorianCalendar: View {
        
        private let dateFormatter = DateFormatter(dateFormat: "dd/MM/yy", calendar: .init(identifier: .gregorian))
        private var dates: [(date: Date, status: OrderStatus)] = []
        
        init() {
            dates.append((date: dateFormatter.date(from: "01/10/2023")!, status: .onGoing))
            dates.append((date: dateFormatter.date(from: "05/10/2023")!, status: .onGoing))
            dates.append((date: dateFormatter.date(from: "10/10/2023")!, status: .completed))
            dates.append((date: dateFormatter.date(from: "05/09/2023")!, status: .completed))
            dates.append((date: dateFormatter.date(from: "15/09/2023")!, status: .onGoing))
        }
        
        var body: some View {
            CalendarView(calendar: Calendar(identifier: .gregorian),
                         selectedDate: Binding.constant(.now),
                         dates: self.dates)
        }
        
    }
    
    static var previews: some View {
        Group {
            GregorianCalendar()
            
            CalendarView(calendar: Calendar(identifier: .islamicUmmAlQura),
                         selectedDate: Binding.constant(.now),
                         dates: [])
            
            CalendarView(calendar: Calendar(identifier: .hebrew),
                         selectedDate: Binding.constant(.now),
                         dates: [])
            
            CalendarView(calendar: Calendar(identifier: .indian),
                         selectedDate: Binding.constant(.now),
                         dates: [])
        }
    }
}
#endif
