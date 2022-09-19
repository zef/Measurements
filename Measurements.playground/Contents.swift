import Foundation

let grams = UnitMass.grams
let pounds = UnitMass.pounds

grams.symbol

var measurement = Measurement(value: 1900, unit: grams)

measurement + measurement

measurement.converted(to: pounds)
measurement

let feet = UnitLength.feet

let width = Measurement(value: 14, unit: feet)
let length = Measurement(value: 10, unit: feet)


//if let data = try? NSKeyedArchiver.archivedData(withRootObject: width, requiringSecureCoding: false) {
//    data
//    print(data)
//    let newWidth = try? NSKeyedUnarchiver.unarchivedObject(ofClass: Measurement, from: data)
//}

