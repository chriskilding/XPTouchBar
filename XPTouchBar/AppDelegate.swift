import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, NSTouchBarDelegate {
    
    var props: XPlaneConnector!
    var touchBarDelegate: MyTouchBar!
    
    func updateTouchBar() {
        NSApplication.shared.windows.forEach { window in
            if let touchBar = window.touchBar {
                touchBarDelegate?.updateNSTouchBar(touchBar)
            }
        }
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        NSApplication.shared.windows.forEach { window in
            window.tabbingMode = .disallowed
            window.standardWindowButton(.miniaturizeButton)?.isEnabled = false
            
            touchBarDelegate = MyTouchBar()
            touchBarDelegate.props = props
            
            window.touchBar = touchBarDelegate.makeTouchBar()
            
            // initial sync of touchbar values with model
            updateTouchBar()
        }
        props.start()
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        props.stop()
    }
    
    
}
