# XPTouchBar

Control [X-Plane](https://www.x-plane.com) with the Mac Touch Bar.

![Screenshot](img/tpm.png)

## Overview

XPTouchBar is a companion app to X-Plane which presents flight controls in the Touch Bar.

XPTouchBar is completely customizable. You choose the controls that appear in the Touch Bar to complement the aircraft you're flying, and the hardware controls you have (e.g. sidestick/yoke, rudder pedals, throttle quadrant).

![Screenshot](img/jet.png)

You could use XPTouchBar as...

- a throttle quadrant (Throttle / Prop / Mixture / Speedbrake / Flaps as needed)
- an avionics panel
- ...anything else you can think of

![Screenshot](img/lights.png)

You can use XPTouchBar on the same machine as X-Plane (e.g. X-Plane on your external monitor, XPTouchBar on your MacBook monitor), or you can use them on different machines (e.g. X-Plane on your gaming PC, XPTouchBar on your Mac as a remote control).

## Design

XPTouchBar aims to provide X-Plane controls which:

- play to the strengths of the Touch Bar (e.g. sliders and multi-state switches)
- are used frequently in flight, or must be quickly accessible during takeoff/landing
- are hard to use with the keyboard or mouse

## Features

XPTouchBar has Touch Bar widgets for the following aircraft controls:

- Speedbrake
- Throttle
- Propeller Pitch
- Mixture
- Flaps
- Landing Gear
- Parking Brake
- Simulation Speed
  - Pause
  - Play (1x speed)
  - Fast Forward (2x speed)
- Camera (view type)
  - Cockpit
  - Chase
  - Circle
  - Forward with HUD
  - Linear Spot
  - Runway
  - Still Spot
  - Tower
- Lights
  - Beacon
  - Land
  - Nav
  - Strobe
  - Taxi
  
XPTouchBar also forwards the following X-Plane keyboard shortcuts for convenience:

| Key | Shortcut             |
|-----|----------------------|
| B   | Parking Brake On/Off |
| G   | Landing Gear Up/Down |
| M   | Show/Hide Map        |
| P   | Play/Pause           |
| Y   | Show/Hide Yoke       |

## Requirements

- Mac with Touch Bar
- macOS 12
- X-Plane 11.55 or higher
- Access to X-Plane's UDP port (default: 49000)
- External monitor (if you are using X-Plane and XPTouchBar on the same machine)

## Setup

Download the app from [GitHub Releases](https://github.com/chriskilding/XPTouchBar/releases), or compile the app from source with Xcode.

## Usage

1. Start X-Plane and load a new flight.
2. Start XPTouchBar. (Configure it if necessary.)
3. Begin your flight.
4. During flight you may need to click into X-Plane to perform certain operations. When you're done, click on XPTouchBar again (or Cmd-Tab to it) to make the Touch Bar controls reappear.

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

If X-Plane is running on a different host or port, go to `XPTouchBar` → `Preferences` to change the connection settings.

## Recommendations

- Don't overcrowd the Touch Bar. (Space is at a premium, so only add the XPTouchBar controls that you most need.)
- Remove unneeded macOS controls from the Touch Bar to make space for the XPTouchBar controls:
  - Use `System Preferences` → `Keyboard` → `Customize Control Strip...` to remove controls from the always-on control strip.
  - Alternatively, untick `System Preferences` → `Keyboard` → `☑️ Show Control Strip` to hide the always-on control strip altogether. This will give apps (like XPTouchBar) the full width of the Touch Bar.

## Troubleshooting

If you can't see the XPTouchBar controls...

- Check that XPTouchBar is open and in focus.
- Check that `System Preferences` → `Keyboard` → `Touch Bar shows` is set to `App Controls`.

If the XPTouchBar controls don't behave as you expect...

- Check the dataref values being sent to X-Plane in the `Debug` tab.
- Check that the aircraft you're flying supports the relevant controls/datarefs properly. (Sometimes the aircraft have bugs.)

## Limitations

**Mac apps can only control the Touch Bar when they are in focus.** Unfortunately this means that if X-Plane and XPTouchBar are on the same computer, and you click into X-Plane to do something, **you need to Cmd-Tab back to XPTouchBar** afterwards. This is something we would like to find a workaround for.

In the meantime, XPTouchBar does some things to help you keep it in focus:

- The minimize button is disabled.
- When the window is closed, the app also quits.
- XPTouchBar forwards some of the most important X-Plane keyboard shortcuts (as described above), so you don't need to switch to X-Plane to use them.
- To justify its presence on your screen, XPTouchBar includes an optional aircraft manuals viewer. (Keeping your aircraft's Operational Speeds page open can be useful.)
