//
//  MeasurementsApp.swift
//  Measurements
//
//  Created by Zef Houssney on 9/12/22.
//

import SwiftUI

@main
struct MeasurementsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            CollectionsView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        printCategories()
        checkDimensions()

//        let collections = DataController.shared.collections
//        print(collections)

//        printSQLiteLocation()

        return true
    }

    func checkDimensions() {
        for dimension in Dimension.Case.allCases {
            print(dimension.description)
        }
    }

    func checkTypes() {
        for dimension in UnitType.allCases.flatMap(\.dimensions) {
//            let type = dimension.unitType
//            print("\(String(describing: type))")
//            print(String(describing: dimension))
            let formatter = MeasurementFormatter()
            formatter.unitStyle = .long
            formatter.unitOptions = .providedUnit

//            let measurement = Foundation.Measurement(value: 12, unit: dimension)
//            let string = formatter.string(from: measurement)
//            print(string)
//            print(dimension.unitTypeName)
            print(dimension.description)
        }
    }

    func printSQLiteLocation() {
        let path = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?.absoluteString.replacingOccurrences(of: "file://", with: "").removingPercentEncoding
        print("SQLite:")
        print(path ?? "Not found")
    }

//
//    func printCategories() {
//        for category in Category.allCases {
//            print(category)
//            for sub in category.subcategories {
//                print("\(sub.rawValue): \(sub.unit.symbol)")
//            }
//
//            print("")
//        }
//    }
}
