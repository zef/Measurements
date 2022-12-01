import Foundation

let grams = UnitMass.grams
let pounds = UnitMass.pounds

grams.symbol


var measurement = Measurement(value: 1900, unit: grams)


measurement + measurement

measurement.converted(to: pounds)
measurement.formatted()

Measurement(value: 1, unit: UnitElectricPotentialDifference.kilovolts).converted(to: .megavolts)

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


let u1 = UnitArea.acres
let u2 = UnitArea.ares

let toConvert = Measurement(value: 1, unit: u1)
toConvert.converted(to: u2)


//
let s = "NSUnitInformationStorage"
let new = s.replacing("NSUnit", with: "").replacing(/^[A-Z]{1}/) { $0.0.lowercased() }
new

UnitVolume.tablespoons.symbol
String(describing: UnitVolume.tablespoons)
String(describing: tbsp)


if let data = try? NSKeyedArchiver.archivedData(withRootObject: width, requiringSecureCoding: false) {
    data
    print(data)
    print(String(data: data, encoding: .utf8))
//    let newWidth = try? NSKeyedUnarchiver.unarchivedObject(ofClass: Measurement, from: data)
}


enum Division: Int, CaseIterable, CustomStringConvertible {
    case whole = 0
    case half
    case quarter
    case eighth
    case sixteenth
    case thirtysecond

    var count: Int {
        NSDecimalNumber(decimal: pow(2, order)).intValue
    }

    var order: Int {
        rawValue
    }

    var description: String {
        return "1/\(count)"
    }

    init(index: Int, maxUnit: Division = .sixteenth) {
        let count = index
        var match: Division?
        let cases = Self.allCases.filter { $0.order < maxUnit.order }
        for (index, division) in cases.reversed().enumerated() {
            let divisor = NSDecimalNumber(decimal: pow(2, index + 1)).intValue
            if (count % divisor) == 0 {
                match = division
            }
        }
        self = match ?? maxUnit
    }
}

for index in 0...16 {
//     half
//    print(index+1, index % 8 == 0)
//     half
    print(index, Division(index: index), "\n")
}
Int(truncating: NSDecimalNumber(decimal: pow(2, 4)))
NSDecimalNumber(decimal: pow(2, 4)).intValue



