import SwiftUI

struct OverView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
                Text("""
Choose the X-Plane controls that are shown in the Touch Bar.

Available controls:

\u{2022} Speedbrake
\u{2022} Throttle
\u{2022} Propeller Pitch
\u{2022} Mixture
\u{2022} Flaps
\u{2022} Landing Gear
\u{2022} Parking Brake
\u{2022} Sim Speed (Play | Pause)
""")

            Button("Customize Touch Bar...", action: customizeTouchBar)
            
            Spacer()
        }
    }
    
    func customizeTouchBar() {
        NSApplication.shared.toggleTouchBarCustomizationPalette(nil)
    }
}
