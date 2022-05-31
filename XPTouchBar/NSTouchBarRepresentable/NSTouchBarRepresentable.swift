import AppKit
import SwiftUI

protocol NSTouchBarRepresentable {
    
    /// Creates the touch bar object and configures its initial state.
    func makeNSTouchBar(context: Context) -> NSTouchBar

    /// Creates the specified item within the touch bar object.
    func makeNSTouchBarItem(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier, context: Context) -> NSTouchBarItem?
    
    /// Updates the state of the specified touch bar with new information from
    /// SwiftUI.
    func updateNSTouchBar(_ touchBar: NSTouchBar, context: Context)
    
    /// Cleans up the presented touch bar (and coordinator) in anticipation of
    /// their removal.
    static func dismantleNSTouchBar(_ touchBar: NSTouchBar, coordinator: Self.Coordinator)
    
    /// A type to coordinate with the touch bar.
    associatedtype Coordinator = Void

    /// Creates the custom instance that you use to communicate changes from
    /// your touch bar to other parts of your SwiftUI interface.
    func makeCoordinator() -> Self.Coordinator

    typealias Context = NSTouchBarRepresentableContext<Self>
}


struct NSTouchBarRepresentableContext<T> where T : NSTouchBarRepresentable {

    /// An instance you use to communicate your touch bar item's behavior and state
    /// out to SwiftUI objects.
    let coordinator: T.Coordinator

    // ...
}
