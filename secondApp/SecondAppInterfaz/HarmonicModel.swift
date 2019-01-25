//
//  HarmonicModel.swift
//  SecondAppInterfaz
//
//  Created by Miguel Lahera Hervilla on 02/10/2018.
//  Copyright © 2018 Miguel Lahera Hervilla. All rights reserved.
//

import Foundation


class HarmonicModel {
    
    static let g = 9.8
    
    var l: Double = 0.3{
        didSet{
            updateW()
        }
    }
    //velocidad angular
    private var w: Double = 0
    
    init(){
        updateW()
    }
    private func updateW(){
        w = sqrt(2*HarmonicModel.g/l) //9.8 gravedad
    }
    func zAt(time t: Double) -> Double{
        return l/2*cos(w*t)
    }
    func vAt(time t: Double) -> Double{
        return -l*w/2*sin(w*t)
    }
    func aAt(time t: Double) -> Double{
        return -HarmonicModel.g*cos(w*t) // 9.8 gravedad
    }
}
