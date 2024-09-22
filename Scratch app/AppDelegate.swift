//
//  AppDelegate.swift
//  Scratch app
//
//  Created by 윤우상 on 6/18/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let viewController = ViewController()
        window = NSWindow(contentViewController: viewController)
        window.setContentSize(NSSize(width: 800, height: 600))
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

