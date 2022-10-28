import Foundation

let grams = UnitMass.grams
let pounds = UnitMass.pounds

grams.symbol


var measurement = Measurement(value: 1900, unit: grams)


measurement + measurement

measurement.converted(to: pounds)
measurement.formatted()


let feet = UnitLength.feet
let cm = UnitLength.centimeters
let feetDimension = Dimension(symbol: feet.symbol)

feet.symbol

let width = Measurement(value: 14, unit: feet)
let length = Measurement(value: 10, unit: feet)
let lengthD = Measurement(value: 10, unit: feetDimension)

length.converted(to: cm)
//lengthD.converted(to: cm)

let cmFormat = Measurement<UnitLength>.FormatStyle(width: .wide)
width.formatted(cmFormat)

let formatter = MeasurementFormatter()

formatter.string(from: measurement)

let tbsp = UnitVolume.tablespoons
let tbspImp = UnitVolume.imperialTablespoons

let volTest = Measurement(value: 10, unit: tbsp)
volTest.converted(to: tbspImp)

//
let s = "NSUnitInformationStorage"
let new = s.replacing("NSUnit", with: "").replacing(/^[A-Z]{1}/) { $0.0.lowercased() }
new



//if let data = try? NSKeyedArchiver.archivedData(withRootObject: width, requiringSecureCoding: false) {
//    data
//    print(data)
//    let newWidth = try? NSKeyedUnarchiver.unarchivedObject(ofClass: Measurement, from: data)
//}

