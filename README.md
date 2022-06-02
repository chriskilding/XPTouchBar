# XPTouchBar

Control [X-Plane](https://www.x-plane.com) with the Mac Touch Bar.

## Overview

XPTouchBar is a companion app to X-Plane which presents flight controls in the Touch Bar.

XPTouchBar is completely customizable. You choose the controls that appear in the Touch Bar to complement the aircraft you're flying, and the hardware controls (sidestick/yoke, rudder pedals, throttle quadrant etc) you have.

You could use XPTouchBar as...

- a throttle quadrant (Throttle / Prop / Mixture / Speedbrake / Flaps as needed)
- an avionics panel
- ...anything else you can think of

## Design

XPTouchBar aims to provide X-Plane controls which:

- play to the strengths of the Touch Bar (e.g. sliders and multi-state switches)
- are used frequently in flight, or must be immediately accessible in takeoff/landing
- are hard to click with your mouse in the on-screen cockpit
- do not translate well to keyboard shortcuts

## Features

XPTouchBar has Touch Bar widgets for the following aircraft controls:

- Speedbrake
- Throttle
- Propeller Pitch
- Mixture
- Flaps
- Landing Gear
- Parking Brake
- Simulation Speed (Pause | Play)
- Lights
  - Beacon
  - Land
  - Nav
  - Strobe
  - Taxi
  - Cockpit
  - Instruments

## Requirements

- Mac with Touch Bar
- macOS 12
- X-Plane 11.55 or higher
- Access to X-Plane's UDP port (default: 49000)

## Setup

Compile the app from source, or otherwise install it on your Mac.

## Usage

1. Start X-Plane and load a new flight.
2. Start XPTouchBar. (Configure it if necessary.)
3. Begin your flight.
4. During flight you may need to click into X-Plane to perform certain operations (e.g. show the map). When you're done, click on XPTouchBar again to make the Touch Bar controls reappear.

## Configuration

### Touch Bar

1. Start XPTouchBar.
2. Click the `Customize Touch Bar...` button.
3. Add controls to the Touch Bar which are relevant to your aircraft and sim setup.

You can add any controls that you find useful. Here are some suggestions:

| Aircraft            | Controls                                     |
|---------------------|----------------------------------------------|
| Cessna 172          | Throttle, Mixture, Flaps                     |
| Cirrus Vision SF50  | Throttle, Flaps, Landing Gear                |
| Boeing 737          | Speedbrake, Throttle, Flaps, Landing Gear    |
| Beechcraft Baron 58 | Throttle, Prop, Mixture, Flaps, Landing Gear |

### UDP connection

XPTouchBar connects over X-Plane's UDP connection. By default it connects to X-Plane on the same machine (`localhost:49000`).

If X-Plane is running on a different host or port, use the `Connection` tab in XPTouchBar to change your connection settings.

## Recommendations

- Don't overcrowd the Touch Bar. (Space is at a premium, so only add the XPTouchBar controls that you most need.)
- Run XPTouchBar on a separate monitor to X-Plane for ease of access.
- Remove unneeded macOS controls from the Touch Bar to make space for the XPTouchBar controls:
  - Use `System Preferences` → `Keyboard` → `Customize Control Strip...` to remove controls from the always-on control strip.
  - Alternatively, untick `System Preferences` → `Keyboard` → `☑️ Show Control Strip` to hide the always-on control strip altogether. This will give apps (like XPTouchBar) the full width of the Touch Bar.

## Troubleshooting

If you can't see the XPTouchBar controls...

- Check that XPTouchBar is open and in focus. (Click on the XPTouchBar window or Dock icon, or use Cmd-Tab, to focus it.)
- Check that `System Preferences` → `Keyboard` → `Touch Bar shows` is set to `App Controls`.

If the XPTouchBar controls don't behave as you expect...

- Check the dataref values being sent to X-Plane in the `Debug` tab.
- Check that the aircraft you're flying supports the relevant controls/datarefs properly. (Sometimes the aircraft have bugs.)

## Limitations

The biggest limitation is that **Mac apps can only control the Touch Bar when they are in focus.** Unfortunately this means **you need to Cmd-Tab between X-Plane and XPTouchBar** whenever you need to click something in X-Plane. This is very much something we would like to find a workaround for.
