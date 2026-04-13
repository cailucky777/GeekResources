# AR Development Module

A 4-week module introducing high school students to Augmented Reality development on iOS using ARKit and RealityKit with SwiftUI.

---

## Prerequisites

Students should have completed the following before starting this module:

- **SwiftUI fundamentals** -- comfortable building views, using state variables, and handling user interaction (see `02-SwiftUI-App-Development`).
- **Swift language basics** -- functions, structs, classes, closures, optionals.
- **A physical iOS device** -- ARKit does not work in the iOS Simulator. Each student (or pair) needs an iPhone or iPad running iOS 16 or later.
- An Apple Developer account (free tier is sufficient for on-device testing via Xcode).

---

## Learning Objectives

By the end of this module, students will be able to:

1. Explain what ARKit is and how it tracks the real world (planes, images, faces).
2. Use RealityKit and `ARViewContainer` to display AR content in a SwiftUI app.
3. Place virtual 3D objects on real-world surfaces using raycasting.
4. Detect and respond to face tracking with ARKit's face mesh.
5. Build and deploy an AR app to a physical iOS device.

---

## Weekly Lesson Outline

| Week | Topic | Key Activities |
|------|-------|----------------|
| 1 | Introduction to AR and ARKit | What is AR, how ARKit works, set up Xcode project, display a basic AR view |
| 2 | Plane Detection and Object Placement | Detect horizontal/vertical planes, tap to place 3D objects, scale and rotate objects |
| 3 | Face Tracking and Effects | Front camera AR, face mesh, attaching 3D content to face anchors, building a face filter |
| 4 | Final AR Project | Students design and build a small AR experience, present to the class |

---

## Hardware and Software Requirements

| Requirement | Details |
|-------------|---------|
| **Mac** | macOS 14 (Sonoma) or later |
| **Xcode** | Version 15 or later |
| **iOS Device** | iPhone or iPad with A12 chip or later, running iOS 16+ |
| **USB Cable** | Lightning or USB-C cable to connect the device to the Mac |
| **Apple ID** | Free Apple Developer account for on-device testing |

### Important Notes

- **ARKit requires a physical device.** The Simulator does not support camera or motion sensors.
- **Face tracking** requires a device with a TrueDepth camera (iPhone X or later, iPad Pro 2018 or later).
- Ensure each student's device is registered in Xcode for development signing before class begins. This process can take time on the first setup.

---

## Folder Structure

```
04-AR-Development/
  README.md                     <-- You are here
  AR-iOS-Tutorial.md            <-- Existing tutorial document
  demos/
    Demo01-PlaceObjects.swift   <-- Tap-to-place AR app
    Demo02-FaceFilter.swift     <-- Face tracking filter app
```

---

## Key Resources

### Apple Documentation

- [ARKit Overview](https://developer.apple.com/augmented-reality/arkit/) -- Apple's official ARKit landing page.
- [ARKit Documentation](https://developer.apple.com/documentation/arkit) -- Full API reference.
- [RealityKit Documentation](https://developer.apple.com/documentation/realitykit) -- The framework for rendering 3D content in AR.
- [Creating an AR Experience](https://developer.apple.com/documentation/arkit/creating-an-ar-experience) -- Apple's introductory guide.

### WWDC Sessions (Recommended Viewing)

- "Build spatial experiences with RealityKit" (WWDC23)
- "What's new in ARKit" (WWDC23)
- "Dive into RealityKit 2" (WWDC21)

### Existing Tutorial

See [AR-iOS-Tutorial.md](./AR-iOS-Tutorial.md) in this folder for a detailed walkthrough of AR concepts and setup.

---

## Tips for Teaching AR

1. **Device management is the biggest challenge.** Budget extra time in Week 1 for device provisioning and Xcode signing issues.
2. **Pair students** if there are not enough devices. One student codes while the other tests on the device, then swap.
3. **Lighting matters.** ARKit's plane detection works best in well-lit rooms with textured surfaces. Avoid blank white tables.
4. **Start simple.** The tap-to-place demo (Demo01) is the most satisfying first AR experience. Get it running before diving into theory.
5. **Record demos.** Since AR is hard to project (the device screen does not look the same on a projector), use QuickTime screen mirroring to show the device screen on the classroom projector.
