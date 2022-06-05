import SwiftUI

struct ContentView: View {
    
    @State private var selectedView: MyTab = .touchBar
    
    @ViewBuilder private var childView: some View {
        switch selectedView {
        case .touchBar:
            TouchBarView()
                .padding()
        case .manuals:
            ManualsView()
        case .debug:
            DebugView()
        }
    }
    
    var body: some View {
        childView
            .toolbar {
                Spacer()
                
                Picker("", selection: $selectedView) {
                    Text("Touch Bar").tag(MyTab.touchBar)
                    Text("Manuals").tag(MyTab.manuals)
                    Text("Debug").tag(MyTab.debug)
                }
                .pickerStyle(.segmented)
                
                
                Spacer()
            }
    }
}

fileprivate enum MyTab {
    case touchBar
    case manuals
    case debug
}
