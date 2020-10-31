//
//  CycleStackView.swift
//  speedoMeter
//
//  Created by Rinoy Francis on 29/10/20.
//

import UIKit

protocol BottomButtonsViewProtocol: class {
    func cycleButtonPressed()
    func joggerButtonPressed()
}

class ButtonView: UIView {

    weak var delegate : BottomButtonsViewProtocol?
    @IBOutlet var fullStack : UIStackView!
    @IBOutlet var joggerView : UIView!
    @IBOutlet var cycleView : UIView!
    @IBOutlet var joggerViewButton : UIView!
    @IBOutlet var cycleViewButton : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func cycleButtonHide() {
        self.cycleView.hide()
    }
    
    func joggerButtonHide() {
        self.joggerView.hide()
    }
    
    func showAllRideOptions() {
        self.cycleView.show()
        self.joggerView.show()
    }
    
    @IBAction func cycleButtonAction(_ sender: Any) {
        self.delegate?.cycleButtonPressed()
    }
    
    @IBAction func joggerButtonAction(_ sender: Any) {
        self.delegate?.joggerButtonPressed()
    }

}


extension UIView {
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
