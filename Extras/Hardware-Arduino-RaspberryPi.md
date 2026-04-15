# Hardware: Arduino and Raspberry Pi

> Code that lights up a real LED feels fundamentally different from code that moves pixels.

Physical computing is the quickest way to make what you build feel magical. Two platforms own the beginner space:

---

## Arduino vs Raspberry Pi — at a Glance

| | **Arduino** | **Raspberry Pi** |
|---|---|---|
| Think of it as | A smart electrical circuit | A tiny Linux computer |
| Language | C++ (Arduino dialect) | Python / anything |
| Boot time | Instant | ~30 seconds |
| Good at | Sensors, motors, LEDs, real-time | Cameras, networking, AI, web servers |
| Needs | USB to your computer | Display/SSH, MicroSD card |
| Starter cost | ~$25 (Uno R3 clone) | ~$45 (Pi 4 basic kit) |
| Complexity | Simple | Full OS |

**Rule of thumb:** control hardware → Arduino. Run a program that uses hardware → Raspberry Pi.

---

## Arduino Quick Start

### What to Buy

- **Arduino Uno R3** (or a clone).
- A **beginner kit** with breadboard, LEDs, resistors, buttons, servos — about $25–40.
- A USB-B cable (comes with most kits).

### Setup

1. Install the **Arduino IDE** or the **Arduino app** (Mac App Store).
2. Plug in the Uno. Select **Board: Arduino Uno** and the matching port.
3. Open the **Blink** example. Upload. The onboard LED blinks.

You are a hardware programmer.

### Minimum Viable Sketch

```cpp
const int LED = 13;

void setup() {
  pinMode(LED, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  digitalWrite(LED, HIGH);
  Serial.println("on");
  delay(500);
  digitalWrite(LED, LOW);
  delay(500);
}
```

### First 5 Things to Build

1. **Blink** — onboard LED.
2. **Button + LED** — pressing turns it on.
3. **Potentiometer → LED brightness.** Analog input.
4. **Servo sweep.** Motors!
5. **Ultrasonic distance sensor.** Display in Serial Monitor.

These take a weekend. They teach you 80% of Arduino.

---

## Raspberry Pi Quick Start

### What to Buy

- **Raspberry Pi 5** (or Pi 4B for cheaper).
- Official case with fan.
- Power supply + microSD card (32 GB+).
- A mini-HDMI cable OR SSH-only setup.

### Setup

1. Download **Raspberry Pi Imager.**
2. Flash **Raspberry Pi OS** to the microSD. In Imager's advanced options, set hostname, Wi-Fi, enable SSH.
3. Insert card, power on.
4. SSH in from your Mac: `ssh pi@raspberrypi.local`.

### First 5 Things to Build

1. **Hello World in Python.**
2. **Blink an LED via GPIO** (use `gpiozero`).
3. **Camera photo** with the Pi Camera module or any USB webcam.
4. **Web server** — Flask page that turns on an LED.
5. **Home-automation bot** — post to Discord when a sensor triggers.

---

## Connecting to iOS

Cool projects combine Pi/Arduino with your iPhone:

- **Bluetooth LE** — Arduino Nano 33 BLE talks directly to CoreBluetooth on iOS.
- **HTTP** — Raspberry Pi runs a Flask server; iPhone app calls it (see `../05-API-and-Networking/`).
- **MQTT** — a pub/sub message broker for tiny messages; iOS libraries and Pi both support it.

---

## Project Ideas

- **Smart plant** — Pi + soil moisture sensor posts to an iOS app when plant is thirsty.
- **Gesture LED** — Arduino reads a sensor; iPhone AR visualizes the data.
- **Arcade button** — big physical button triggers something in your iOS app over Bluetooth.
- **Classroom attendance** — Pi camera + simple face-recognition marks students present.

---

## Safety

- **Always power off** before changing wires.
- **Use resistors** with LEDs (usually 220–330 Ω).
- **Don't run 9V into a 3.3V pin.** You'll fry the board.
- **Double-check polarity** for components with a + and −.

---

## Resources

- [Arduino Project Hub](https://projecthub.arduino.cc) — thousands of projects with wiring diagrams.
- [Adafruit Learn](https://learn.adafruit.com) — beginner-friendly tutorials.
- [pinout.xyz](https://pinout.xyz) — Raspberry Pi GPIO reference.
