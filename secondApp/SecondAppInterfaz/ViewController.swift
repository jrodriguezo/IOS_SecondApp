//
//  ViewController.swift
//  SecondAppInterfaz
//
//  Created by Jesus on 02/10/2018.
//  Copyright © 2018 Jesus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ParametricFunctionViewDataSource {
    let model = HarmonicModel()
    
    @IBOutlet weak var ztPFView: ParametricFunctionView!
    @IBOutlet weak var vtPFView: ParametricFunctionView!
    @IBOutlet weak var atPFView: ParametricFunctionView!
    @IBOutlet weak var vzPFView: ParametricFunctionView!
    
    @IBOutlet weak var lLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var ztLabel: UILabel!
    @IBOutlet weak var vtLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    
    @IBOutlet weak var lSlider: UISlider!
    @IBOutlet weak var tSlider: UISlider!
    
    
    var poiTime: Double = 0.0 {
        didSet{
            ztPFView.setNeedsDisplay()
            vtPFView.setNeedsDisplay()
            atPFView.setNeedsDisplay()
            vzPFView.setNeedsDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ztPFView.dataSource = self
        vtPFView.dataSource = self
        atPFView.dataSource = self
        vzPFView.dataSource = self
        
        /*let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        /*leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)*/
        leftSwipe.direction = .left
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
        /*rightSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(rightSwipe)*/
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        */
        lSlider.sendActions(for: .valueChanged)
        tSlider.sendActions(for: .valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    /* @IBAction func updateL(_ sender: UISlider) {
        model.l = Double (sender.value)
        update()
    }
    
    @IBAction func updateT(_ sender: UISlider) {
        poiTime = Double(sender.value)
        update()
    }*/
    @IBAction func updateL(_ sender: UISlider) {
        model.l = Double (sender.value)
        update()
    }
    @IBAction func pinchT(_ sender: UIPinchGestureRecognizer) {
        tSlider.value = Float(sender.scale)
        updateT(tSlider)
    }
    
    @IBAction func tapForView(_ sender: UITapGestureRecognizer) {
        print("estoy pulsando 😎👍")
    }
    
    @IBAction func pinchL(_ sender: UIPinchGestureRecognizer) {
        lSlider.value = Float(sender.scale)
        updateL(lSlider)
    }
    
    
    
    @IBAction func updateT(_ sender: UISlider) {
        poiTime = Double(sender.value)
        update()
    }
    
    private func update(){
        let a = model.aAt(time:poiTime)
        let v = model.vAt(time:poiTime)
        let z = model.zAt(time:poiTime)
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        lLabel.text = ""
        ztLabel.text = ""
        vtLabel.text = ""
        atLabel.text = ""
        timeLabel.text = ""
        
        if let fl = formatter.string(from: model.l as NSNumber){
            lLabel.text = "\(fl) m"
            
            
        }
        if let fa = formatter.string(from: a as NSNumber){
            atLabel.text = "\(fa) m/seg2"
            
            
        }
        if let fv = formatter.string(from: v as NSNumber){
            vtLabel.text = "\(fv) m/seg"
            
            
        }
        if let fz = formatter.string(from: z as NSNumber){
            ztLabel.text = "\(fz) m"
            
            
        }
        if let ft = formatter.string(from: poiTime as NSNumber){
            timeLabel.text = "\(ft) seg"
            
            
        }
        
        ztPFView.setNeedsDisplay()
        vtPFView.setNeedsDisplay()
        atPFView.setNeedsDisplay()
        vzPFView.setNeedsDisplay()
        
        
    }
    
    func startIndexFor(_ functionView: ParametricFunctionView) -> Double{
        return 0
    }
    
    func endIndexFor(_ functionView: ParametricFunctionView) -> Double{
        return 5
    }
    
    func functionView(_ functionView: ParametricFunctionView, pointAt index: Double) -> FunctionPoint{
        switch functionView {
        case ztPFView:
            let time = index
            let z = model.zAt(time: time)
            return FunctionPoint(x: time, y: z)
        case vtPFView:
            let time = index
            let v = model.vAt(time: time)
            return FunctionPoint(x: time, y: v)
        case atPFView:
            let time = index
            let a = model.aAt(time: time)
            return FunctionPoint(x: time, y: a)
        case vzPFView:
            let time = index
            let v = model.vAt(time: time)
            let z = model.zAt(time: time)
            return FunctionPoint(x: z, y: v)
        default:
            return FunctionPoint(x: 0, y: 0)
        }
    }
    
    func pointsOfInterestFor(_ functionView: ParametricFunctionView) -> [FunctionPoint]{
        let time = poiTime
        switch functionView {
        case ztPFView:
            let z = model.zAt(time: time)
            return [FunctionPoint(x: time, y: z)]
        case vtPFView:
            let v = model.vAt(time: time)
            return [FunctionPoint(x: time, y: v)]
        case atPFView:
            let a = model.aAt(time: time)
            return [FunctionPoint(x: time, y: a)]
        case vzPFView:
            let v = model.vAt(time: time)
            let z = model.zAt(time: time)
            return [FunctionPoint(x: z, y: v)]
        default:
            return []
        }
    }
}

