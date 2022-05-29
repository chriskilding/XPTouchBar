# XPTouchBar

Show [X-Plane](https://www.x-plane.com) simulator controls in the Mac Touch Bar.

## Overview

XPTouchBar is a companion app to X-Plane which presents commonly used flight controls in the Touch Bar. In essence it is a simple throttle quadrant (with extras). You use it in conjunction with your sidestick/yoke (and rudder pedals if you've got them).

XPTouchBar is helpful when:

- You do not have a hardware throttle quadrant.
- You want to map other flight controls (e.g. Landing Gear, Parking Brake) to the Touch Bar for ease of use.

## Features

XPTouchBar has Touch Bar widgets for the following aircraft controls:

- Speedbrake
- Throttle
- Propeller Pitch
- Mixture
- Flaps
- Landing Gear
- Parking Brake

## Requirements

- Mac with Touch Bar
- macOS 12
- X-Plane 11.55 or higher
- Access to X-Plane's UDP port (default: 49000)

## Setup

Compile the app from source, or otherwise install it on your Mac.

## Usage

1. Start X-Plane and initiate a flight.
2. Start XPTouchBar. (Configure if necessary.)
3. Begin your flight, using the controls that you set up in the Touch Bar.
4. During flight you may need to click into X-Plane to perform certain operations (e.g. show the map). When you're done, click on XPTouchBar again to make the Touch Bar controls reappear.

## Configuration

### Touch Bar items

1. Start XPTouchBar.
2. Click the 'Customize Touch Bar...' button.
3. Add the controls to the Touch Bar which are relevant to your aircraft and sim setup.

You can add any controls you find useful. Here are some suggestions:

| Aircraft           | Controls                                                 |
|--------------------|----------------------------------------------------------|
| Cessna 172         | Throttle, Mixture, Flaps, Parking Brake                  |
| Cirrus Vision SF50 | Throttle, Flaps, Landing Gear, Parking Brake             |
| Boeing 737         | Speedbrake, Throttle, Flaps, Landing Gear, Parking Brake |

### UDP connection

XPTouchBar connects over X-Plane's UDP connection. By default it connects to X-Plane on the same machine (`localhost:49000`).

If X-Plane is running on a different host or port, use the Connection tab in XPTouchBar to change your connection settings.

## Recommendations

- Run XPTouchBar on a separate monitor to X-Plane for ease of access.

## Limitations

- Mac apps can only control the Touch Bar when they are in focus. Unfortunately this means you need to Cmd-Tab between X-Plane and XPTouchBar whenever you need to click something in X-Plane. This is something we'd like to work around.
- Some third party aircraft do not support the relevant X-Plane datarefs properly. As a result they may not behave as you expect when controlled from XPTouchBar.