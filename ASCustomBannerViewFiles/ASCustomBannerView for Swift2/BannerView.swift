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
    private var auxImage = UIImageView()
    private var images = [UIImageView]()
    private var timer = NSTimer()
    
    func createBanner(imagesArray:[String], widthScreen:CGFloat)
    {
        if widthScreen > 415
        {
            self.aspectWidth = 415
        }
        else
        {
            self.aspectWidth = widthScreen
        }
        
        self.aspectHeight = self.aspectWidth*0.4166
        self.dragging = false
        self.moving = false
        self.backgroundColor = UIColor.clearColor()
        self.createImageList(imagesArray)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("actionAutoSlide"), userInfo: nil, repeats: true)
    }
    
    private func createImageList(array:[String])
    {
        for i in 0 ... array.count-1
        {
            list.insert(UIImage(named: array[i])!)
        }
        
        for i in 0 ... 4
        {
            var imagen = UIImageView()
            switch i {
            case 0:
                imagen.image = self.list.getBeforePrevious().image
                break
            case 1:
                imagen.image = self.list.getPrevious().image
                break
            case 2:
                imagen.image = self.list.getCurrent().image
                break
            case 3:
                imagen.image = self.list.getRear().image
                break
            case 4:
                imagen.image = self.list.getAfterRear().image
                break
            default:
                break
            }
            self.images.append(imagen)
            let initX = getInitX()+(self.aspectWidth*CGFloat(-2+i))
            self.images[i].frame = CGRect(x: initX, y: 0, width: self.aspectWidth, height: self.aspectHeight)
            self.addSubview(images[i])
        }
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
        
        let centerInit = getInitX()
        
        if dragging && !moving
        {
            self.images[2].frame.origin.x = position.x - oldX + centerInit
            for i in 0 ... 4
            {
                if i != 2
                {
                    self.images[i].frame.origin.x = self.images[2].frame.origin.x+(self.aspectWidth*CGFloat(-2+i))
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if dragging && !moving
        {
            let centerInit = getInitX()
            
            if self.images[2].frame.origin.x < centerInit-self.aspectWidth/2
            {
                UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.moveToLeft()
                }) { _ in
                    self.list.moveNext()
                    self.resetImages()
                    self.dragging = false
                }
            }
            else if self.images[2].frame.origin.x < centerInit
            {
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.resetImages()
                }) { _ in
                    self.dragging = false
                }
            }
                
            else if self.images[2].frame.origin.x > centerInit+self.aspectWidth/2
            {
                UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.moveToRight()
                }) { _ in
                    self.list.moveBack()
                    self.resetImages()
                    self.dragging = false
                }
            }
            else if self.images[2].frame.origin.x > centerInit
            {
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                    {
                        self.resetImages()
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
            let centerInit = getInitX()
            
            self.moving = true
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations:
                {
                    self.moveToLeft()
            }) { _ in
                self.list.moveNext()
                self.resetImages()
                self.moving = false
            }
        }
    }
    
    private func resetImages()
    {
        let center = getInitX()
    
        for i in 0 ... 4
        {
            switch i {
                case 0:
                    self.images[i].image = self.list.getBeforePrevious().image
                    break
                case 1:
                    self.images[i].image = self.list.getPrevious().image
                    break
                case 2:
                    self.images[i].image = self.list.getCurrent().image
                    break
                case 3:
                    self.images[i].image = self.list.getRear().image
                    break
                case 4:
                    self.images[i].image = self.list.getAfterRear().image
                    break
                default:
                    break
            }
            let initX = getInitX()+(self.aspectWidth*CGFloat(-2+i))
            self.images[i].frame.origin.x = initX
        }
    }
    
    private func moveToLeft()
    {
        for i in 0 ... 4
        {
            let initX = getInitX()+(self.aspectWidth*CGFloat(-3+i))
            self.images[i].frame.origin.x = initX
        }
    }
    
    private func moveToRight()
    {
        for i in 0 ... 4
        {
            let initX = getInitX()+(self.aspectWidth*CGFloat(-1+i))
            self.images[i].frame.origin.x = initX
        }
    }
    
    private func getInitX()->CGFloat
    {
        return UIScreen.mainScreen().bounds.width/2 - aspectWidth/2
    }
    
    func getHeightSize()->CGFloat
    {
        return self.aspectHeight
    }
}
