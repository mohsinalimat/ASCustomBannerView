//
//  BannerView.swift
//  bannerDemo
//
//  Created by Alan Roldán Maillo on 24/6/16.
//  Copyright © 2016 Alan Roldán Maillo. All rights reserved.
//

import Foundation
import UIKit

class BannerView: UIView
{
    private var aspectWidth = CGFloat()
    private var aspectHeight = CGFloat()
    private var dragging = Bool()
    private var moving = Bool()
    private var oldX = CGFloat()
    private var list = LinkedList()
    private var currentImage = UIImageView()
    private var nextImage = UIImageView()
    private var backImage = UIImageView()
    private var timer = NSTimer()
    
    func createBanner(imagesArray:[String], widthScreen:CGFloat)
    {
        self.aspectWidth = widthScreen
        self.aspectHeight = widthScreen*0.4166
        self.dragging = false
        self.moving = false
        self.backgroundColor = UIColor.clearColor()
        
        self.createImageList(imagesArray)
        self.addSubview(currentImage)
        self.addSubview(nextImage)
        self.addSubview(backImage)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("actionAutoSlide"), userInfo: nil, repeats: true)
    }
    
    private func createImageList(array:[String])
    {
        for i in 0 ... array.count-1
        {
            list.insert(UIImage(named: array[i])!)
        }
        
        self.currentImage = UIImageView(image: self.list.getCurrent().image)
        self.currentImage.frame = CGRect(x: 0, y: 0, width: self.aspectWidth, height: self.aspectHeight)
        self.backImage = UIImageView(image: self.list.getPrevious().image)
        self.backImage.frame = CGRect(x: -self.aspectWidth, y: 0, width: self.aspectWidth, height: self.aspectHeight)
        self.nextImage = UIImageView(image: self.list.getRear().image)
        self.nextImage.frame = CGRect(x: self.aspectWidth, y: 0, width: self.aspectWidth, height: self.aspectHeight)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if !dragging && !moving
        {
            self.dragging = true
            let position :CGPoint = touches.first!.locationInView(self)
            self.oldX = position.x
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let position :CGPoint = touches.first!.locationInView(self)
        
        if dragging && !moving
        {
            self.currentImage.frame.origin.x = position.x - oldX
            self.nextImage.frame.origin.x = self.currentImage.frame.origin.x + self.aspectWidth
            self.backImage.frame.origin.x = self.currentImage.frame.origin.x - self.aspectWidth
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if dragging && !moving
        {
            if self.currentImage.frame.origin.x < -self.aspectWidth/2
            {
                UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.currentImage.frame.origin.x = -self.aspectWidth
                        self.nextImage.frame.origin.x = self.currentImage.frame.origin.x+self.aspectWidth
                        self.backImage.frame.origin.x = self.currentImage.frame.origin.x-self.aspectWidth
                }) { _ in
                    self.list.moveNext()
                    self.backImage.image = self.list.getPrevious().image
                    self.backImage.frame.origin.x = -self.aspectWidth
                    self.currentImage.image = self.list.getCurrent().image
                    self.currentImage.frame.origin.x = 0
                    self.nextImage.image = self.list.getRear().image
                    self.nextImage.frame.origin.x = self.aspectWidth
                    self.dragging = false
                }
            }
            else if self.currentImage.frame.origin.x < 0
            {
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.currentImage.frame.origin.x = 0
                        self.nextImage.frame.origin.x = self.currentImage.frame.origin.x+self.aspectWidth
                        self.backImage.frame.origin.x = self.currentImage.frame.origin.x-self.aspectWidth
                }) { _ in
                    self.dragging = false
                }
            }
                
            else if self.currentImage.frame.origin.x > self.aspectWidth/2
            {
                UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.currentImage.frame.origin.x = self.aspectWidth
                        self.backImage.frame.origin.x = self.currentImage.frame.origin.x-self.aspectWidth
                        self.nextImage.frame.origin.x = self.currentImage.frame.origin.x+self.aspectWidth
                }) { _ in
                    self.list.moveBack()
                    self.backImage.image = self.list.getPrevious().image
                    self.backImage.frame.origin.x = -self.aspectWidth
                    self.currentImage.image = self.list.getCurrent().image
                    self.currentImage.frame.origin.x = 0
                    self.nextImage.image = self.list.getRear().image
                    self.nextImage.frame.origin.x = self.aspectWidth
                    self.dragging = false
                }
            }
            else if self.currentImage.frame.origin.x > 0
            {
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.currentImage.frame.origin.x = 0
                        self.backImage.frame.origin.x = self.currentImage.frame.origin.x-self.aspectWidth
                        self.nextImage.frame.origin.x = self.currentImage.frame.origin.x+self.aspectWidth
                }) { _ in
                    self.dragging = false
                }
            }
            else
            {
                self.dragging = false
            }
        }
    }
    
    func actionAutoSlide()
    {
        if !dragging
        {
            self.moving = true
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                {
                    self.currentImage.frame.origin.x = -self.aspectWidth
                    self.nextImage.frame.origin.x = self.currentImage.frame.origin.x+self.aspectWidth
                    self.backImage.frame.origin.x = self.currentImage.frame.origin.x-self.aspectWidth
            }) { _ in
                self.list.moveNext()
                self.backImage.image = self.list.getPrevious().image
                self.backImage.frame.origin.x = -self.aspectWidth
                self.currentImage.image = self.list.getCurrent().image
                self.currentImage.frame.origin.x = 0
                self.nextImage.image = self.list.getRear().image
                self.nextImage.frame.origin.x = self.aspectWidth
                self.moving = false
            }
        }
    }
    
    func getHeightSize()->CGFloat
    {
        return self.aspectHeight
    }
}
