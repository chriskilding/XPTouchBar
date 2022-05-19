import AppKit
import SwiftUI

class NSTouchBarViewController<Content: View, Representable: NSTouchBarRepresentable>: NSViewController, NSTouchBarDelegate {
    
    var content: (() -> Content)!
    var representable: Representable!
    
    // TODO keep this framework-private
    // TODO is this the best place to cache this?
    var context: NSTouchBarRepresentableContext<Representable>!
    
    override func loadView() {
        self.view = NSHostingView(rootView: content())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeTouchBar() -> NSTouchBar? {
        context = NSTouchBarRepresentableContext<Representable>(coordinator: representable.makeCoordinator())
        let touchBar = representable.makeNSTouchBar(context: context)
        touchBar.delegate = self
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        return representable.makeNSTouchBarItem(makeItemForIdentifier: identifier, context: context)
    }
    
    
}
