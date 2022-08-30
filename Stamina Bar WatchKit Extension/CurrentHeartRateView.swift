//
//  CurrentHeartRateView.swift
//  Stamina Bar WatchKit Extension
//
//  Created by Zachary Ellis on 8/24/22.
//

import Foundation
import SwiftUI

struct CurrentHeartRateView: View {
    var currentHeartRate: Int
    var minimumHeartRate: Int
    var maximumHeartRate: Int
    
    var body: some View {
        VStack (alignment: .trailing, spacing: 10) {
            if currentHeartRate <= Int(Double(maximumHeartRate) * 0.5) {
                Image("100")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if currentHeartRate > Int(Double(maximumHeartRate) * 0.5) && currentHeartRate <= Int(Double(maximumHeartRate) * 0.6) {
                Image("95")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if currentHeartRate > Int(Double(maximumHeartRate) * 0.6) && currentHeartRate <= Int(Double(maximumHeartRate) * 0.7) {
                Image("90")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if currentHeartRate > Int(Double(maximumHeartRate) * 0.7) && currentHeartRate <= Int(Double(maximumHeartRate) * 0.75) {
                Image("85")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if currentHeartRate > Int(Double(maximumHeartRate) * 0.75) && currentHeartRate <= Int(Double(maximumHeartRate) * 0.8) {
                Image("80")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if currentHeartRate > Int(Double(maximumHeartRate) * 0.8) && currentHeartRate <= Int(Double(maximumHeartRate) * 0.85) {
                Image("75")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if currentHeartRate > Int(Double(maximumHeartRate) * 0.85) && currentHeartRate <= Int(Double(maximumHeartRate) * 0.9) {
                Image("50")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("25")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            VStack {
                HStack {
                    Text("\(currentHeartRate) BPM")
                        .font(Font.custom("AvenirLTStd-Book", size: 16))
                    Image(systemName: "suit.heart.fill")
                        .resizable()
//                        .font(Font.system(.largeTitle).bold())
                        .frame(width: 12, height: 12)
                        .foregroundColor(.red)
                }
            }
        }
    }
}
