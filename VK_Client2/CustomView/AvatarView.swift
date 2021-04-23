//
//  AvatarView.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 21.10.2020.
//

import UIKit

var imageName: String? = nil

@IBDesignable class AvatarView: UIView {
    
    
    
    var avatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    var shadow = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    @IBInspectable var shadowColor = UIColor.black.cgColor
    @IBInspectable var width = 50
    @IBInspectable var height = 50
    @IBInspectable var shadowOpacity: Float = 0.5
    
    
     override init(frame: CGRect) {
           super.init(frame: frame)
           
           //setup()
       }
       
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        setup()
       }
       
       override func layoutSubviews() {
            super.layoutSubviews()
            avatar.frame = CGRect(x: 0, y: 0, width: width, height: height)
            shadow.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
       }
       
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
    }
        private func setup(){
            backgroundColor = .clear
            
            avatar.layer.borderWidth = 2.0
            avatar.layer.borderColor = UIColor.clear.cgColor
            avatar.layer.cornerRadius = 25
            avatar.image = UIImage(named: imageName ?? "imageNN")
            
            avatar.layer.masksToBounds = true
            addSubview(avatar)
            
            shadow.layer.borderWidth = 0.5
            shadow.layer.borderColor = UIColor.black.cgColor
            shadow.layer.cornerRadius = 25
            shadow.layer.shadowColor = shadowColor
            shadow.layer.shadowOpacity = shadowOpacity
            shadow.layer.shadowRadius = 25
            shadow.layer.shadowOffset = CGSize.zero
            addSubview(shadow) //shadow not work
    }
}
