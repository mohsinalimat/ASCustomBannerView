//
//  ImageItem.swift
//  bannerDemo
//
//  Created by Alan Roldán Maillo on 24/6/16.
//  Copyright © 2016 Alan Roldán Maillo. All rights reserved.
//

import Foundation
import UIKit

class LinkedList
{
    private var current = ImageItem()
    private var tail  = ImageItem()
    private var head = ImageItem()
    private var size = 0
    
    func getCurrent()->UIImageView
    {
        return current.getImage()
    }
    
    func getPrevious()->UIImageView
    {
        return current.getBack().getImage()
    }
    
    func getRear()->UIImageView
    {
        return current.getNext().getImage()
    }
    
    func getAfterRear()->UIImageView
    {
        return current.getNext().getNext().getImage()
    }
    
    func getBeforePrevious()->UIImageView
    {
        return current.getBack().getBack().getImage()
    }
    
    func getSize()->Int
    {
        return self.size
    }
    
    func moveNext()
    {
        let aux = ImageItem(imagen: self.current.getImage().image!, backn: self.current.getBack(), nextn: self.current.getNext())
        self.current = aux.getNext()
    }
    
    func moveBack()
    {
        let aux = ImageItem(imagen: self.current.getImage().image!, backn: self.current.getBack(), nextn: self.current.getNext())
        self.current = aux.getBack()
    }
    
    func insert(image:UIImage)
    {
        let newNode = ImageItem(imagen: image)
        if size == 0
        {
            newNode.setNext(newNode)
            newNode.setBack(newNode)
            self.current = newNode
            self.tail = newNode
            self.head = newNode
            size+=1
        }
        else
        {
            newNode.setNext(self.head)
            newNode.setBack(self.tail)
            self.tail.setNext(newNode)
            self.tail = newNode
            self.head.setBack(self.tail)
            size+=1
        }
    }
}
