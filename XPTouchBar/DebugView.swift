import SwiftUI

struct DebugView: View {
    
    @Binding var speedbrake: Double
    @Binding var throttle: Double
    @Binding var pitch: Double
    @Binding var mixture: Double
    @Binding var flaps: Double
    @Binding var gear: Gear
    @Binding var parkingBrake: ParkingBrake
    @Binding var simSpeed: SimSpeed
    
    var body: some View {
        Form {
            Slider(value: $speedbrake, in: 0...1) {
                Text(Speedbrake.name)
            }
            .tint(Color(Speedbrake.color))
            
            Slider(value: $throttle, in: 0...1) {
                Text(Throttle.name)
            }
            .tint(Color(Throttle.color))
            
            Slider(value: $pitch, in: 0...1) {
                Text(Pitch.name)
            }
            .tint(Color(Pitch.color))
            
            Slider(value: $mixture, in: 0...1) {
                Text(Mixture.name)
            }
            .tint(Color(Mixture.color))
            
            Slider(value: $flaps, in: 0...1) {
                Text(Flaps.name)
            }
            .tint(Color(Flaps.color))
            
            Picker("Gear", selection: $gear, content: {
                Text(Gear.down.description).tag(Gear.down)
                Text(Gear.up.description).tag(Gear.up)
            })
            .pickerStyle(.segmented)
            
            Picker("Parking Brake", selection: $parkingBrake, content: {
                Text(ParkingBrake.on.description).tag(ParkingBrake.on)
                Text(ParkingBrake.off.description).tag(ParkingBrake.off)
            })
            .pickerStyle(.segmented)
            
            Picker("Sim Speed", selection: $simSpeed, content: {
                Text(SimSpeed.pause.description).tag(SimSpeed.pause)
                Text("1x").tag(SimSpeed.play)
            })
            .pickerStyle(.segmented)
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(speedbrake: .constant(0), throttle: .constant(0), pitch: .constant(1), mixture: .constant(1), flaps: .constant(0), gear: .constant(.down), parkingBrake: .constant(.on), simSpeed: .constant(.play))
    }
}
