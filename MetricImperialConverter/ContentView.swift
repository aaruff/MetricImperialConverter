//
//  ContentView.swift
//  MetricImperialConverter
//
//  Created by Anwar Ruff on 10/25/22.
//

import SwiftUI

enum MeasurementSystem {
    case imperial, metric
}

enum ImperialLengthUnit: Int {
   case inch = 0, foot, yard, mile
}

enum MetricLengthUnit: Int {
   case millimeter = 0, centimeter, meter, kilometer
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
    
    @State private var fromChoice = MeasurementSystem.imperial
    @State private var fromUnitChoice = ImperialLengthUnit.inch
    @State private var toChoice = MeasurementSystem.metric
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
                    Picker("From", selection: $fromChoice) {
                        ForEach(fromChoice) { i in
                            if fromChoice == MeasurementSystem.imperial {
                                Text(unitSystems[i])
                            }
                            else {
                                
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("From Unit", selection: $fromUnitChoice) {
                        ForEach(0..<4) { i in
                            Text(units[fromChoice][i])
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("To")) {
                    Picker("From", selection: $toChoice) {
                        ForEach(0..<2) { i in
                            Text(unitSystems[i])
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("From Unit", selection: $toUnitChoice) {
                        ForEach(0..<4) { i in
                            Text(units[toChoice][i])
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
            }
            .navigationBarTitle("Metric to Imperial")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
