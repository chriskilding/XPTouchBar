import AppKit
import SwiftUI

struct NSTouchBarViewControllerRepresentable<Content: View, Representable: NSTouchBarRepresentable>: NSViewControllerRepresentable {
    
    var content: () -> Content
    var representable: Representable
    
    init(content: @escaping () -> Content, representable: Representable) {
        self.content = content
        self.representable = representable
    }
    
    func makeNSViewController(context: Context) -> NSTouchBarViewController<Content, Representable> {
        let vc = NSTouchBarViewController<Content, Representable>()
        vc.content = content
        vc.representable = representable
        return vc
    }
    
    func updateNSViewController(_ nsViewController: NSTouchBarViewController<Content, Representable>, context: Context) {
        if let touchBar = nsViewController.touchBar {
            let context = nsViewController.context!
            representable.updateNSTouchBar(touchBar, context: context)
        }
    }
    
}

