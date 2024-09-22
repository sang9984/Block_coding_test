//
//  BlockView.swift
//  Scratch app
//
//  Created by 윤우상 on 6/18/24.
//

import Cocoa

class BlockView: NSView {
    var initialLocation: CGPoint = .zero

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.blue.cgColor
        self.layer?.cornerRadius = 8
        
        let panGesture = NSPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func handlePan(_ gesture: NSPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        
        if gesture.state == .began {
            initialLocation = self.frame.origin
        }
        
        if gesture.state != .cancelled {
            let newOrigin = CGPoint(x: initialLocation.x + translation.x, y: initialLocation.y + translation.y)
            self.setFrameOrigin(newOrigin)
        }
        
        if gesture.state == .ended {
            snapToGrid()
        }
    }

    func snapToGrid() {
        let gridSize: CGFloat = 20
        var newOrigin = self.frame.origin
        newOrigin.x = round(newOrigin.x / gridSize) * gridSize
        newOrigin.y = round(newOrigin.y / gridSize) * gridSize
        self.setFrameOrigin(newOrigin)
    }
}

