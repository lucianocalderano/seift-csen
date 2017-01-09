//
//  BinomiCtrl.swift
//  CsenCinofilia
//
//  Created by Luciano Calderano on 28/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit
class RankCtrl: MyViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet private var pickYear: UIPickerView?
    @IBOutlet private var pickRall: UIPickerView?
    @IBOutlet private var viewRally: UIView?
    
    private var arrYear = [Int]()
    private var arrRall = [
        Lng("#rankRal0"),
        Lng("#rankRal1"),
        Lng("#rankRal2"),
        Lng("#rankRal3"),
        ]
    private let isCross = (Challenge.typeName == ChallengeType.Rall.rawValue)
        
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let annIni = isCross ? 2015 : 2014
        let annFin = self.ultimoAnno()
        for i in (annIni...annFin).reversed() {
            arrYear.append(i)
        }

        pickYear!.layer.borderColor = UIColor.myBlue().cgColor
        pickYear!.layer.borderWidth = 1
        pickYear!.reloadAllComponents()

        viewRally?.isHidden = self.showPickerRally()
    }

    private func showPickerRally () -> Bool {
        if (isCross) {
            pickRall!.layer.borderColor = UIColor.myRed().cgColor
            pickRall!.layer.borderWidth = 1
            pickRall!.reloadAllComponents()
            return false
        }
        return true
    }

    private func ultimoAnno () -> Int {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.month, .year], from: Date())
        
        return (isCross && components.month! < 9 ? components.year! - 1 : components.year)!
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (pickerView == pickRall) ? arrRall.count : arrYear.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myPickerCell = MyPicker()
        myPickerCell.text = (pickerView == pickRall) ? arrRall[row] : String(arrYear[row])
        return myPickerCell
    }
    
    @IBAction private func okTapped () {
        let ctrl = RankOptsCtrl.instanceFromSb(self.storyboard)
        ctrl.year = Int (arrYear[pickYear!.selectedRow(inComponent: 0)])
        ctrl.rallySelection = pickRall!.selectedRow(inComponent: 0)
        self.navigationController!.show(ctrl, sender:self)
    }
}

class MyPicker: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.font = UIFont.mySizeBold(20)
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.myBlue()
    }
}

