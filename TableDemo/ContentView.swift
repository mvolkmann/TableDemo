import SwiftUI

struct Person: Identifiable {
    let givenName: String
    let familyName: String
    let emailAddress: String
    let id = UUID()
}

struct ContentView: View {
    @State private var people = [
        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
    ]
    @State private var selectedPeople = Set<Person.ID>()
    @State private var sortOrder = [KeyPathComparator(\Person.givenName)]

    var body: some View {
        VStack {
            // Tables are mostly useless in iOS.
            // From https://developer.apple.com/documentation/swiftui/table,
            // "On iOS, and in other situations with a
            // compact horizontal size class, tables don’t show headers
            // and collapse all columns after the first.
            // If you present a table on iOS, you can
            // customize the table’s appearance by implementing
            // compact-specific logic in the first column.
            Table(people, selection: $selectedPeople, sortOrder: $sortOrder) {
                TableColumn("Given Name", value: \.givenName)
                TableColumn("Family Name", value: \.familyName)
                TableColumn("E-Mail Address", value: \.emailAddress)
            }
            Text("\(selectedPeople.count) people selected")
        }
        .padding()
        .onChange(of: sortOrder) {
            people.sort(using: $0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
