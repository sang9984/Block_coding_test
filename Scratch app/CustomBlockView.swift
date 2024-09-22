//
//  CustomBlockView.swift
//  Scratch app
//
//  Created by 윤우상 on 6/18/24.
//

import Cocoa

class CustomBlockView: NSView {
    var initialLocation: CGPoint = .zero

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.layer?.cornerRadius = 8
        
        let panGesture = NSPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawBlock()
    }

    private func drawBlock() {
        guard (NSGraphicsContext.current?.cgContext) != nil else { return }
        let path = NSBezierPath()

        // Define the block shape here
        let blockWidth = self.bounds.width
        let blockHeight = self.bounds.height
        let notchWidth: CGFloat = 20
        let notchDepth: CGFloat = 10
        
        // Start drawing from the top left corner
        path.move(to: CGPoint(x: 0, y: blockHeight))
        
        // Top edge with notch
        path.line(to: CGPoint(x: notchWidth, y: blockHeight))
        path.line(to: CGPoint(x: notchWidth + notchDepth, y: blockHeight - notchDepth))
        path.line(to: CGPoint(x: notchWidth + notchDepth + notchWidth, y: blockHeight - notchDepth))
        path.line(to: CGPoint(x: notchWidth + 2 * notchDepth + notchWidth, y: blockHeight))
        path.line(to: CGPoint(x: blockWidth, y: blockHeight))
        
        // Right edge
        path.line(to: CGPoint(x: blockWidth, y: 0))
        
        // Bottom edge
        path.line(to: CGPoint(x: 0, y: 0))
        
        // Close path
        path.close()

        // Fill color
        NSColor.blue.setFill()
        path.fill()

        // Stroke color
        NSColor.black.setStroke()
        path.lineWidth = 2
        path.stroke()
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
