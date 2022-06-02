import SwiftUI

struct OverView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Choose the relevant X-Plane Touch Bar controls for your aircraft.")

            Button("Customize Touch Bar...", action: customizeTouchBar)
            
            Spacer()
            
            Label("If the X-Plane Touch Bar controls disappear, click this window to restore them.", systemImage: "info.circle.fill")
        }
    }
    
    func customizeTouchBar() {
        NSApplication.shared.toggleTouchBarCustomizationPalette(nil)
    }
}
