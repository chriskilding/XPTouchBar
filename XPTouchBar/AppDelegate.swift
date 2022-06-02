import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
        
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.isAutomaticCustomizeTouchBarMenuItemEnabled = true
        NSApplication.shared.windows.forEach { window in
            window.tabbingMode = .disallowed
            window.standardWindowButton(.miniaturizeButton)?.isEnabled = false
        }
    }
        
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
