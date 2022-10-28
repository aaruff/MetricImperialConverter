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
    
    @State private var unitValue = 0.0
    
    @State private var fromMeasurementSystemSelection = MeasurementSystem.imperial
    @State private var fromUnitChoice = ImperialLengthUnit.inch
    @State private var toMeasurementSystemSelection = MeasurementSystem.metric
    @State private var toUnitChoice = MetricLengthUnit.millimeter
    
    
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
                    Picker("From - Measurement System", selection: $fromMeasurementSystemSelection) {
                        ForEach(MeasurementSystem.allCases, id: \.self) { system in
                            Text(system.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    // From - Measurement Unit
                    Picker("From - Unit", selection: $fromUnitChoice) {
                        if fromMeasurementSystemSelection == MeasurementSystem.imperial {
                            ForEach(ImperialLengthUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                        else {
                            ForEach(MetricLengthUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("To")) {
                    Picker("To - Measurement System", selection: $toMeasurementSystemSelection) {
                        ForEach(MeasurementSystem.allCases, id: \.self) { system in
                            Text(system.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("To - Unit", selection: $toUnitChoice) {
                        if toMeasurementSystemSelection == MeasurementSystem.imperial {
                            ForEach(ImperialLengthUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                        else {
                            ForEach(MetricLengthUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
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
