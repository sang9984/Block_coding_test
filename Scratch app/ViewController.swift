//
//  ViewController.swift
//  Scratch app
//
//  Created by 윤우상 on 6/18/24.
//

import Cocoa

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        
        let addButton = NSButton(title: "Add Block", target: self, action: #selector(addBlock))
        addButton.frame = NSRect(x: 20, y: 20, width: 100, height: 40)
        view.addSubview(addButton)
    }

    @objc func addBlock() {
        let block = CustomBlockView(frame: NSRect(x: 100, y: 100, width: 200, height: 80))
        view.addSubview(block)
    }
}
