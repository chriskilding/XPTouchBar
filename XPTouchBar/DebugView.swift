import SwiftUI

struct DebugView: View {
    
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    
    var body: some View {
        Form {
            Slider(value: $throttle, in: 0...1) {
                Text("Throttle")
            }
            .tint(Color.white)
            
            Slider(value: $pitch, in: 0...1) {
                Text("Pitch")
            }
            
            Slider(value: $mixture, in: 0...1) {
                Text("Mixture")
            }
            .tint(Color.red)
            
            Slider(value: $flaps, in: 0...1) {
                Text("Flaps")
            }
            .tint(Color.green)
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(throttle: .constant(0), pitch: .constant(1), mixture: .constant(1), flaps: .constant(0))
    }
}
