//
//  ContentView.swift
//  MetricImperialConverter
//
//  Created by Anwar Ruff on 10/25/22.
//

import SwiftUI

enum MeasurementSystem: String, CaseIterable {
    case imperial, metric
}

enum ImperialLengthUnit: String, CaseIterable {
   case inch, foot, yard, mile
}

enum MetricLengthUnit: String, CaseIterable {
   case millimeter, centimeter, meter, kilometer
}


struct Metric {
    let index = 1
    var metricType: MetricLengthUnit
    var lengthValue: Double
    
    func toMilliMeter() -> Double {
        switch metricType {
        case .millimeter:
            return lengthValue
        case .centimeter:
            return lengthValue*10
        case .meter:
            return lengthValue*1000
        case .kilometer:
            return lengthValue*1000000
        }
    }
}

struct Imperial{
    let index = 0
    var imperialType: ImperialLengthUnit
    var lengthValue: Double
    
    func toInch() -> Double {
        switch imperialType {
        case .inch:
            return lengthValue
        case .foot:
            return lengthValue*12
        case .yard:
            return lengthValue*12*3
        case .mile:
            return lengthValue*12*3*1760
        }
    }
}

struct ContentView: View {
    private let Imperial = 0
    private let Metric = 1
    
    private let measurementSystemChoices = MeasurementSystem.allCases
    private let metricChoices = MetricLengthUnit.allCases
    private let imperialChoices = ImperialLengthUnit.allCases
    
    @State private var unitValue = 0.0
    
    
    @State private var fromMeasurementSystemChoice = 0
    @State private var fromUnitChoice = 0
    @State private var toMeasurementSystemChoice = 0
    @State private var toUnitChoice = 0

    
    private var convertedUnitValue: Double {
        return 0.0
    }
    
    private var unitFormatter = NumberFormatter()
    
    init() {
        unitFormatter.numberStyle = .decimal
        unitFormatter.maximumFractionDigits = 2
        unitFormatter.minimumFractionDigits = 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Unit Value")) {
                    TextField("Unit Value", value: $unitValue, formatter: unitFormatter)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("From")) {
                    Picker("From - Measurement System", selection: $fromMeasurementSystemChoice) {
                        ForEach(0..<measurementSystemChoices.count, id: \.self) { i in
                            Text(measurementSystemChoices[i].rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
