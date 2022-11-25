//
//  FractionSelectionView.swift
//  Measurements
//
//  Created by Zef Houssney on 11/23/22.
//

import SwiftUI

struct FractionSelectionView: View {

    struct Marker: Identifiable, CustomStringConvertible {
        enum Division: Int, CaseIterable, CustomStringConvertible {
            case whole = 0
            case half
            case quarter
            case eighth
            case sixteenth
            case thirtySecond
//            case sixtyFourth

            var count: Int {
                NSDecimalNumber(decimal: pow(2, order)).intValue
            }

            var order: Int {
                rawValue
            }

            var description: String {
                return "1/\(count)"
            }

            init(index: Int, maxUnit: Division) {
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

            static var pickerOptions: [Self] {
                [.eighth, .sixteenth, .thirtySecond]
            }
        }

        var id: Int { count }
        // the segment index within an inch
        let count: Int
        let maxUnit: Division

        var divison: Division {
            return Division(index: count, maxUnit: maxUnit)
        }

        var width: CGFloat {
            return CGFloat(maxUnit.order - divison.order + 1)
        }

        var height: CGFloat {
            let reduction: CGFloat = 16
            var height: CGFloat = 110
            height = height - (CGFloat(divison.order) * reduction)
            return height
        }

        var description: String {
            let normalizedCount = count * divison.count / maxUnit.count
            return "\(normalizedCount)/\(divison.count)"
        }
    }

    @State var division = Marker.Division.thirtySecond
    @State var dragPosition: CGFloat = 32
    @State private var markerData: [MarkerData] = []
    @State var selectedMarker = Marker(count: 0, maxUnit: .whole)


    var body: some View {
        VStack {
            Picker("Precision", selection: $division) {
                ForEach(Marker.Division.pickerOptions, id: \.self) { division in
                    Text(division.description)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 50)
            .padding(.vertical, 80)

            rulerView
                .padding(.horizontal, 40)
            VStack {
                Rectangle()
                    .frame(width: 4, height: 40)
                    .foregroundColor(.red)
                Text(selectedMarker.description)
                    .font(.custom("Courier New", fixedSize: 26))
                    .bold()
            }
            .position(x: dragPosition+30-4, y: 40)
        }
    }

    var rulerView: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Spacer()
            ForEach(0...division.count, id: \.self) { index in
                let marker = Marker(count: index, maxUnit: division)
                //                    Text("\(marker.height)")
                Rectangle()
                    .frame(width: marker.width, height: marker.height)
//                    .frame(height: marker.height)
                    .foregroundColor(.black)
                    .background() {
                        GeometryReader { geometry in
                            Rectangle()
                                .fill(Color.clear)
                                .preference(key: MarkerPreferenceKey.self,
                                            value: [MarkerData(index: index, bounds: geometry.frame(in: .named("RulerSpace")))])
                        }

                    }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .onPreferenceChange(MarkerPreferenceKey.self) { value in
            markerData = value
            print("new values", markerData)
        }
        .gesture(drag)
        .coordinateSpace(name: "RulerSpace")
    }

    var drag: some Gesture {
        DragGesture().onChanged({ value in
//            print("value \(value.location)")
            if let item = markerData.first(where: { $0.bounds.contains(value.location) }) {
                dragPosition = item.bounds.midX
                selectedMarker = Marker(count: item.index, maxUnit: division)
                print("intersection", item)
            }

        })
    }
}

struct MarkerData: Equatable {
    let index: Int
    let bounds: CGRect
}

struct MarkerPreferenceKey: PreferenceKey {
    typealias Value = [MarkerData]

    static var defaultValue: [MarkerData] = []

    static func reduce(value: inout [MarkerData], nextValue: () -> [MarkerData]) {
        value.append(contentsOf: nextValue())
    }
}


struct FractionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
//        Text("hi")
        FractionSelectionView()
    }
}
