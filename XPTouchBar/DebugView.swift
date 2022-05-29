import SwiftUI

struct DebugView: View {
    
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    
    
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
            
            Picker("Gear", selection: $gear, content: {
                Text("Down").tag(Gear.down)
                Text("Up").tag(Gear.up)
            })
            .pickerStyle(.segmented)
            
            Picker("Parking Brake", selection: $parkingBrake, content: {
                Text("On").tag(ParkingBrake.on)
                Text("Off").tag(ParkingBrake.off)
            })
            .pickerStyle(.segmented)
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(throttle: .constant(0), pitch: .constant(1), mixture: .constant(1), flaps: .constant(0), gear: .constant(.down), parkingBrake: .constant(.on))
    }
}
