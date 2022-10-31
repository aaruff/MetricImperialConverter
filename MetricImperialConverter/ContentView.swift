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
    static let typeId = 1
    
    static func inchesToMillimeters(inches: Double) -> Double {
        return inches*25.4
        
    }
    
    static func toMilliMeter(unitChoice: MetricLengthUnit, value: Double) -> Double {
        switch unitChoice {
        case .millimeter:
            return value
        case .centimeter:
            return value*10
        case .meter:
            return value*1000
        case .kilometer:
            return value*1000000
        }
    }
    static func millimeterToUnit(unitChoice: MetricLengthUnit, value: Double) -> Double {
        switch unitChoice {
        case .millimeter:
            return value
        case .centimeter:
            return value/10
        case .meter:
            return value/1000
        case .kilometer:
            return value/1000000
        }
    }
}

struct Imperial {
    static let typeId: Int = 0
    
    static func milimetersToInches(milimeters: Double) -> Double {
        return milimeters*0.0393701
    }
    
    static func toInch(unitChoice: ImperialLengthUnit, value: Double) -> Double {
        switch unitChoice {
        case .inch:
            return value
        case .foot:
            return value*12
        case .yard:
            return value*12*3
        case .mile:
            return value*12*3*1760
        }
    }
    
    static func inchToUnit(unitChoice: ImperialLengthUnit, value: Double) -> Double {
        switch unitChoice {
        case .inch:
            return value
        case .foot:
            return value/12
        case .yard:
            return value/(12*3)
        case .mile:
            return value/(12*3*1760)
        }
    }
}

struct ContentView: View {
    private let metricChoices = MetricLengthUnit.allCases
    private let imperialChoices = ImperialLengthUnit.allCases
    
    @State private var unitValue = 0.0
    @FocusState private var unitValueFocus
    
    @State private var fromMeasurementSystemChoice: Int = 0
    @State private var fromUnitChoice = 0
    @State private var toMeasurementSystemChoice = 0
    @State private var toUnitChoice = 0

    
    private var convertedUnitValue: Double {
        // Imperial -> Metric
        if fromMeasurementSystemChoice == Imperial.typeId && toMeasurementSystemChoice == Metric.typeId {
            
            let fromValueInches = Imperial.toInch(unitChoice: ImperialLengthUnit.allCases[fromUnitChoice], value: unitValue)
            let toValueMillimeters = fromValueInches*25.4
            return Metric.millimeterToUnit(unitChoice: MetricLengthUnit.allCases[toUnitChoice], value: toValueMillimeters)
        }
        // Metric -> Imperial
        else if fromMeasurementSystemChoice == Metric.typeId && toMeasurementSystemChoice == Imperial.typeId {
            let fromValueMillimeters = Metric.toMilliMeter(unitChoice: MetricLengthUnit.allCases[toUnitChoice], value: unitValue)
            let toValueInches = fromValueMillimeters*0.0393701
            return Imperial.inchToUnit(unitChoice: ImperialLengthUnit.allCases[toUnitChoice], value: toValueInches)
        }
        // Metric -> Metric
        else if fromMeasurementSystemChoice == Metric.typeId && toMeasurementSystemChoice == Metric.typeId {
            let fromValueMillimeters = Metric.toMilliMeter(unitChoice: MetricLengthUnit.allCases[fromUnitChoice], value: unitValue)
            return Metric.millimeterToUnit(unitChoice: MetricLengthUnit.allCases[toUnitChoice], value: fromValueMillimeters)
        }
        // Imperial -> Imperial
        else {
            let fromValueInches = Imperial.toInch(unitChoice: ImperialLengthUnit.allCases[fromUnitChoice], value: unitValue)
            return Imperial.inchToUnit(unitChoice: ImperialLengthUnit.allCases[toUnitChoice], value: fromValueInches)
        }
    }
    
    private var unitFormatter = NumberFormatter()
    private var convertedLengthFormatter = NumberFormatter()
    
    init() {
        unitFormatter.numberStyle = .decimal
        unitFormatter.maximumFractionDigits = 2
        unitFormatter.minimumFractionDigits = 0
        convertedLengthFormatter.numberStyle = .decimal
        convertedLengthFormatter.maximumFractionDigits = 6
        convertedLengthFormatter.minimumFractionDigits = 0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Unit Value")) {
                    TextField("Unit Value", value: $unitValue, formatter: unitFormatter)
                        .keyboardType(.decimalPad)
                        .focused($unitValueFocus)
                }

                Section(header: Text("From")) {
                    Picker("From - Measurement System", selection: $fromMeasurementSystemChoice) {
                        ForEach(0..<MeasurementSystem.allCases.count, id: \.self) { i in
                            Text(MeasurementSystem.allCases[i].rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if fromMeasurementSystemChoice == Imperial.typeId {
                        Picker("Unit Choice", selection: $fromUnitChoice) {
                            ForEach(0..<ImperialLengthUnit.allCases.count, id: \.self) { i in
                                Text(ImperialLengthUnit.allCases[i].rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    else {
                        Picker("Unit Choice", selection: $fromUnitChoice) {
                            ForEach(0..<MetricLengthUnit.allCases.count, id: \.self) { i in
                                Text(MetricLengthUnit.allCases[i].rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section(header: Text("To")) {
                    Picker("To - Measurement System", selection: $toMeasurementSystemChoice) {
                        ForEach(0..<MeasurementSystem.allCases.count, id: \.self) { i in
                            Text(MeasurementSystem.allCases[i].rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if toMeasurementSystemChoice == Imperial.typeId {
                        Picker("Unit Choice", selection: $toUnitChoice) {
                            ForEach(0..<ImperialLengthUnit.allCases.count, id: \.self) { i in
                                Text(ImperialLengthUnit.allCases[i].rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    else {
                        Picker("Unit Choice", selection: $toUnitChoice) {
                            ForEach(0..<MetricLengthUnit.allCases.count, id: \.self) { i in
                                Text(MetricLengthUnit.allCases[i].rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                }
                
                Section(header: Text("Converted Unit Value")) {
                    Text("\(convertedUnitValue as NSNumber, formatter: convertedLengthFormatter)")
                }

            }
            .navigationBarTitle(Text("Length Converter"))
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                       unitValueFocus = false
                    }
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
