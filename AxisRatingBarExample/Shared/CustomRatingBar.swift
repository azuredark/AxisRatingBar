//
//  CustomRatingBar.swift
//  AxisRatingBarExample
//
//  Created by jasu on 2022/02/20.
//  Copyright (c) 2022 jasu All rights reserved.
//

import SwiftUI
import AxisRatingBar

struct CustomRatingBar: View {
    
    let axisMode: ARAxisMode
    
    @State private var starCount: CGFloat = 5
    @State private var innerRatio: CGFloat = 1
    @State private var spacing: CGFloat = 6
    @State private var fillMode: ARFillMode = .half
    
    @State private var value1: CGFloat = 1.50
    @State private var value2: CGFloat = 0.50
    @State private var value3: CGFloat = 2.50
    @State private var value4: CGFloat = 0.50
    
    @State private var selection: Int = 0
    
    private var content: some View {
        let constant1 = ARConstant(rating: 3,
                                   size: CGSize(width: 36, height: 36),
                                   spacing: spacing,
                                   fillMode: fillMode,
                                   axisMode: axisMode,
                                   valueMode: .point)
        let constant2 = ARConstant(rating: 4,
                                   size: CGSize(width: 44, height: 44),
                                   spacing: spacing,
                                   fillMode: fillMode,
                                   axisMode: axisMode,
                                   valueMode: .ratio)
        let constant3 = ARConstant(rating: 5,
                                   size: axisMode == .horizontal ? CGSize(width: 44, height: 60) : CGSize(width: 60, height: 44),
                                   spacing: spacing,
                                   fillMode: fillMode,
                                   axisMode: axisMode,
                                   valueMode: .point)
        let constant4 = ARConstant(rating: 6,
                                   size: CGSize(width: 44, height: 44),
                                   spacing: spacing,
                                   fillMode: fillMode,
                                   axisMode: axisMode,
                                   valueMode: .ratio)
        return Group {
            Group {
                VStack {
                    Text("\(value1, specifier: "%.2f")")
                    AxisRatingBar(value: $value1, constant: constant1) {
                        ARStar(count: round(starCount), innerRatio: innerRatio)
                            .stroke()
                            .fill(Color.gray)
                    } foreground: {
                        ARStar(count: round(starCount), innerRatio: innerRatio)
                            .fill(Color.accentColor)
                    }
                }
            }
            Group {
                Divider().padding(axisMode == .vertical ? 10 : 0)
                VStack {
                    Text("\(value2, specifier: "%.2f")")
                    AxisRatingBar(value: $value2, constant: constant2) {
                        ARStar(count: round(starCount), innerRatio: innerRatio)
                            .fill(Color.gray.opacity(0.2))
                    } foreground: {
                        ARStar(count: round(starCount), innerRatio: innerRatio)
                            .fill(Color.accentColor)
                    }
                }
            }
            Group {
                Divider().padding(axisMode == .vertical ? 10 : 0)
                VStack {
                    Text("\(value3, specifier: "%.2f")")
                    AxisRatingBar(value: $value3, constant: constant3) {
                        Capsule()
                            .fill(Color.orange)
                    } foreground: {
                        Capsule()
                            .fill(Color.blue)
                            .padding(2)
                    }
                }
            }
            Group {
                Divider().padding(axisMode == .vertical ? 10 : 0)
                VStack {
                    Text("\(value4, specifier: "%.2f")")
                    AxisRatingBar(value: $value4, constant: constant4) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 44))
                            .foregroundColor(Color.gray.opacity(0.2))
                    } foreground: {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 44))
                            .foregroundColor(Color.red)
                    }
                }
            }
        }
    }
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            if axisMode == .horizontal {
                VStack(alignment: .center) {
                    content
                        .padding(.bottom)
                }
            }else {
                HStack(alignment: .bottom) {
                    content
                        .padding(.bottom)
                }
            }
            Spacer()
            Divider()
            HStack {
                Text("StarCount : ")
                Slider(value: $starCount, in: 1...10)
                Text("\(starCount, specifier: "%.2f")")
            }
            HStack {
                Text("InnerRatio : ")
                Slider(value: $innerRatio, in: 0...2)
                Text("\(innerRatio, specifier: "%.2f")")
            }
            Divider()
            Picker("", selection: $fillMode) {
                Text("Full").tag(ARFillMode.full)
                Text("Half").tag(ARFillMode.half)
                Text("Precise").tag(ARFillMode.precise)
            }
            .pickerStyle(.segmented)
            HStack {
                Text("Spacing : ")
                Slider(value: $spacing, in: 0...20)
                Text("\(spacing, specifier: "%.2f")")
            }
        }
        .padding()
        .animation(.easeInOut, value: starCount)
        .animation(.easeInOut, value: innerRatio)
    }
}

struct CustomRatingBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomRatingBar(axisMode: .horizontal)
    }
}
