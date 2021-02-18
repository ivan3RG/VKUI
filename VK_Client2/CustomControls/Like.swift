//
//  Like.swift
//  VK_Client2
//
//  Created by Иван Кочетков on 22.10.2020.
//

import UIKit

var likeCount: [Int] = []
var buttonState:[Bool] = []

@IBDesignable class Like: UIControl {
    var likeButton = HeartButton(frame: CGRect(x: 280, y: 0, width: 20, height: 20))
    var likeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 280, height: 20))
    var heartColor: UIColor = .blue
    var fillHeartColor: UIColor = .white
    var serv = Services()
    
    func setupView() {
        
        /*if buttonState[indexLike] == true{
            fillHeartColor = .red
            heartColor = .red
        } else {
            fillHeartColor = .white
            heartColor = .blue
        }
        
        likeLabel.text = "\(likeCount[indexLike] )"*/
        likeLabel.textColor = heartColor
        likeLabel.textAlignment = .right;
        
        likeButton.addTarget(self, action: #selector(updateLikes(_:)), for: .touchUpInside)
        likeButton.strokeColor = heartColor
        likeButton.fillColor = fillHeartColor
        likeButton.setNeedsDisplay()
        
        addSubview(likeButton)
        addSubview(likeLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    @objc private func updateLikes(_ sender: HeartButton) {
        
        serv.addLike(ownerId: "161330237", token: session.token, v: session.v, itemId: "457245268") { (items) in
            self.likeLabel.text = String(items)
            self.fillHeartColor = .red
            self.heartColor = .red
            self.setupView()
            
       /*if buttonState[stateLike] == false {
            heartColor = .red
            likeCount[indexLike] += 1
            fillHeartColor = .red
            buttonState[stateLike] =  true
            self.setupView()
        }else{
            heartColor = .blue
            likeCount[indexLike] -= 1
            fillHeartColor = .white
            buttonState[stateLike] =  false
            self.setupView()
        }*/
    }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
