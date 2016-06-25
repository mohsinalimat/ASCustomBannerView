//
//  ImageItem.swift
//  bannerDemo
//
//  Created by Alan Roldán Maillo on 24/6/16.
//  Copyright © 2016 Alan Roldán Maillo. All rights reserved.
//

import Foundation
import UIKit

class ImageItem
{
    private var image : UIImageView!
    private var next : ImageItem!
    private var back : ImageItem!
    
    init()
    {
        
    }
    
    init(imagen:UIImage)
    {
        self.image = UIImageView(image: imagen)
    }
    
    init(imagen:UIImage, backn:ImageItem, nextn:ImageItem)
    {
        self.image = UIImageView(image: imagen)
        self.next = nextn
        self.back = backn
    }
    
    func getImage()->UIImageView
    {
        return self.image
    }
    
    func getNext()->ImageItem
    {
        return self.next
    }
    
    func getBack()->ImageItem
    {
        return self.back
    }
    
    func setNext(siguiente:ImageItem)
    {
        self.next = siguiente
    }
    
    func setBack(anterior:ImageItem)
    {
        self.back = anterior
    }
    
}