//
//  ContentView.swift
//  Stamina Bar WatchKit Extension
//
//  Created by Zachary Ellis on 8/24/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    // MARK: - Wellness/Heart Data fields to manipulate
    let heartRateQuantity = HKUnit(from: "count/min")
    private var healthStore = HKHealthStore()
    @State private var minHeartRate: Int = -1
    @State private var maxHeartRate: Int = 0
    @State private var currentHeartRate = 0

    // MARK: - Stamina Bar simplifies Heart Rate Zones
    var body: some View {
        VStack (alignment: .trailing, spacing: 10) {
            
            if currentHeartRate == 0 {
                Image("Refresh")
            } else if (currentHeartRate < 100) {
                Image("100")
            } else if (currentHeartRate < 110) {
                Image("95")
            } else if (currentHeartRate < 120) {
                Image("90")
            } else if (currentHeartRate < 125) {
                Image("85")
            } else if (currentHeartRate < 135) {
                Image("80")
            } else if (currentHeartRate < 140) {
                Image("75")
            } else if (currentHeartRate < 150) {
                Image("70")
            } else if (currentHeartRate < 155) {
                Image("65")
            } else if (currentHeartRate < 160) {
                Image("60")
            } else if (currentHeartRate < 165) {
                Image("55")
            } else if (currentHeartRate < 170) {
                Image("50")
            } else if (currentHeartRate < 175) {
                Image("45")
            } else if (currentHeartRate < 185) {
                Image("35")
            } else if (currentHeartRate < 190) {
                Image("30")
            } else {
                Image("25")
            }
    // MARK: - UI Elements Under Stamina Bar
            HStack {
                    Button {
                        start()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }   .frame(width: 60, height: 40)
                        .cornerRadius(5)
                        .tint(.mint)
                    Text("\(currentHeartRate) BPM")
                    
                if currentHeartRate == 0 {
                    Image(systemName: "suit.heart.fill")
                } else {
                    Image(systemName: "suit.heart.fill")
                    .foregroundColor(.red)
                }
            }
        }
        .padding()
    }
        
    // MARK: - Set up HealthKit
    func start() {
        autorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
    }
    
    func autorizeHealthKit() {
        let healthKitTypes: Set = [
        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        
        ]

        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
    
    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        
        // 1
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        // 2
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // 3
        guard let samples = samples as? [HKQuantitySample] else {
            return
        }
            
        self.process(samples, type: quantityTypeIdentifier)

        }
        
        // 4
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        // 5
        
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        var lastHeartRate = 0.0
        
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
            }
            DispatchQueue.main.async {
                self.currentHeartRate = Int(lastHeartRate)
                if self.maxHeartRate < self.currentHeartRate {
                    self.maxHeartRate = self.currentHeartRate
                }
                if self.minHeartRate == -1 || self.minHeartRate > self.currentHeartRate {
                    self.minHeartRate = self.currentHeartRate
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
