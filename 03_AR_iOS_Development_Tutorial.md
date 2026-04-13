# AR (Augmented Reality) iOS Development Tutorial

A comprehensive guide to building AR experiences on iOS, from beginner to advanced, covering ARKit, RealityKit, and visionOS.

---

## Table of Contents

1. [Introduction to AR on Apple Platforms](#introduction-to-ar-on-apple-platforms)
2. [Level 1: Getting Started — Your First AR App](#level-1-getting-started--your-first-ar-app)
3. [Level 2: 3D Content and Interactions](#level-2-3d-content-and-interactions)
4. [Level 3: Plane Detection and Object Placement](#level-3-plane-detection-and-object-placement)
5. [Level 4: Face Tracking and Body Tracking](#level-4-face-tracking-and-body-tracking)
6. [Level 5: Image and Object Recognition](#level-5-image-and-object-recognition)
7. [Level 6: Advanced AR Experiences](#level-6-advanced-ar-experiences)
8. [Level 7: AR with Unity on iOS](#level-7-ar-with-unity-on-ios)
9. [Level 8: visionOS and Spatial Computing](#level-8-visionos-and-spatial-computing)
10. [Resources and Next Steps](#resources-and-next-steps)

---

## Introduction to AR on Apple Platforms

### What is AR?

Augmented Reality (AR) overlays digital content (3D objects, text, images, sounds) onto the real world through a device's camera. On iOS, Apple provides powerful frameworks for building AR experiences.

### Apple's AR Technology Stack

```
┌─────────────────────────────────────────────┐
│            Your App / SwiftUI               │
├─────────────────────────────────────────────┤
│          RealityKit (High-level)            │
│    3D rendering, physics, animations        │
├─────────────────────────────────────────────┤
│           ARKit (Mid-level)                 │
│   World tracking, scene understanding       │
├─────────────────────────────────────────────┤
│     Hardware: Camera, LiDAR, IMU, GPS       │
└─────────────────────────────────────────────┘
```

| Framework | Purpose | When to Use |
|---|---|---|
| **ARKit** | Core AR functionality — tracking, scene understanding, hit-testing | When you need low-level AR control |
| **RealityKit** | 3D rendering engine optimized for AR | For rendering 3D content in AR |
| **Reality Composer Pro** | Visual tool for creating 3D scenes | For creating content without code |
| **SceneKit** | Older 3D engine (still supported) | Legacy projects |

### Hardware Requirements

| Feature | Minimum Device | Sensor |
|---|---|---|
| Basic AR (World Tracking) | iPhone 6s / iPad (5th gen) | Camera + IMU |
| Face Tracking | iPhone X (TrueDepth camera) | Front-facing depth |
| People Occlusion | iPhone XR / XS | A12 chip + Camera |
| LiDAR Scanning | iPhone 12 Pro / iPad Pro 2020 | LiDAR scanner |
| Body Tracking | iPhone XR / XS | A12 chip + Camera |
| Object Capture | iPhone 12 Pro+ | LiDAR + Camera |

---

## Level 1: Getting Started — Your First AR App

### Prerequisites

- macOS with Xcode 16+ installed
- A physical iOS device (AR does NOT work in the Simulator)
- Basic Swift and SwiftUI knowledge

### 1.1 Creating an AR Project

1. Open Xcode.
2. **File > New > Project**.
3. Select **Augmented Reality App**.
4. Configure:
   - **Product Name:** MyFirstAR
   - **Interface:** SwiftUI
   - **Content Technology:** RealityKit
5. Click **Create**.

### 1.2 Understanding the Template

Xcode generates a basic AR app. Let's understand the key file:

```swift
// ContentView.swift
import SwiftUI
import RealityKit

struct ContentView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Create a 3D box
        let mesh = MeshResource.generateBox(size: 0.1)  // 10cm box
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])

        // Create an anchor at the world origin
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(modelEntity)

        // Add to the scene
        arView.scene.anchors.append(anchor)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}
```

### 1.3 Running on Device

1. Connect your iPhone via USB.
2. Select your device in the Xcode toolbar (not a Simulator).
3. Configure signing:
   - Go to the project's **Signing & Capabilities** tab.
   - Select your development team.
4. Press `Cmd + R` to build and run.
5. Point your camera at a flat surface — you should see a blue metallic box appear!

### 1.4 Adding a Camera Privacy Description

AR apps require camera access. In `Info.plist`, add:

```xml
<key>NSCameraUsageDescription</key>
<string>This app uses the camera for augmented reality.</string>
```

> Xcode's AR template usually adds this automatically, but verify it's there.

### 1.5 Modifying 3D Objects

```swift
// Different shapes
let box = MeshResource.generateBox(size: 0.1)
let sphere = MeshResource.generateSphere(radius: 0.05)
let plane = MeshResource.generatePlane(width: 0.2, depth: 0.2)
let text = MeshResource.generateText("Hello AR!",
    extrusionDepth: 0.01,
    font: .systemFont(ofSize: 0.05))

// Different materials
let red = SimpleMaterial(color: .red, isMetallic: false)
let metallic = SimpleMaterial(color: .gray, isMetallic: true)
let transparent = SimpleMaterial(color: .blue.withAlphaComponent(0.5), isMetallic: false)

// Positioning
modelEntity.position = SIMD3<Float>(0, 0.05, 0)  // 5cm above anchor
modelEntity.scale = SIMD3<Float>(2, 2, 2)         // Double size
modelEntity.orientation = simd_quatf(angle: .pi / 4, axis: [0, 1, 0])  // 45° rotation
```

### Level 1 Exercise

Build an app that places three different colored shapes (box, sphere, cylinder) on a detected horizontal surface, arranged in a row.

---

## Level 2: 3D Content and Interactions

### 2.1 Loading USDZ Models

Apple uses the USDZ file format for 3D content. You can find free models at [developer.apple.com/augmented-reality/quick-look/](https://developer.apple.com/augmented-reality/quick-look/).

```swift
func makeUIView(context: Context) -> ARView {
    let arView = ARView(frame: .zero)

    // Load a USDZ model
    if let modelEntity = try? ModelEntity.loadModel(named: "toy_robot") {
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(modelEntity)
        arView.scene.anchors.append(anchor)
    }

    return arView
}
```

### 2.2 Tap to Place Objects

```swift
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)

        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        arView.addGestureRecognizer(tapGesture)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            guard let arView = recognizer.view as? ARView else { return }
            let location = recognizer.location(in: arView)

            // Raycast to find a surface
            if let result = arView.raycast(
                from: location,
                allowing: .estimatedPlane,
                alignment: .horizontal
            ).first {
                // Create and place a sphere at the tap location
                let mesh = MeshResource.generateSphere(radius: 0.03)
                let material = SimpleMaterial(
                    color: UIColor.random(),
                    isMetallic: true
                )
                let entity = ModelEntity(mesh: mesh, materials: [material])

                let anchor = AnchorEntity(
                    raycastResult: result
                )
                anchor.addChild(entity)
                arView.scene.anchors.append(anchor)
            }
        }
    }
}

// Helper extension
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
```

### 2.3 Adding Physics

```swift
// Create a floor for physics
let floor = ModelEntity(
    mesh: .generatePlane(width: 5, depth: 5),
    materials: [OcclusionMaterial()]  // Invisible but physical
)
floor.generateCollisionShapes(recursive: false)
floor.components.set(PhysicsBodyComponent(
    massProperties: .default,
    mode: .static
))

// Create a bouncing ball
let ball = ModelEntity(
    mesh: .generateSphere(radius: 0.05),
    materials: [SimpleMaterial(color: .red, isMetallic: true)]
)
ball.generateCollisionShapes(recursive: false)
ball.components.set(PhysicsBodyComponent(
    massProperties: .init(mass: 1.0),
    material: .generate(friction: 0.5, restitution: 0.8),
    mode: .dynamic
))
ball.position = SIMD3(0, 0.5, 0)  // Start 50cm above the floor

anchor.addChild(floor)
anchor.addChild(ball)
```

### 2.4 Gesture-Based Interactions

```swift
// Make entity respond to gestures
modelEntity.generateCollisionShapes(recursive: true)

// Enable built-in gestures in RealityKit
arView.installGestures([.translation, .rotation, .scale], for: modelEntity)
```

This allows users to:
- **Drag** (translation) — move the object on the surface
- **Rotate** (two-finger rotation) — spin the object
- **Scale** (pinch) — resize the object

### Level 2 Exercise

Build a furniture placement app where users can:
1. Tap to place a 3D furniture model (use Apple's free USDZ models).
2. Drag it to reposition.
3. Pinch to resize.
4. Two-finger rotate to orient it.

---

## Level 3: Plane Detection and Object Placement

### 3.1 Configuring Plane Detection

```swift
let config = ARWorldTrackingConfiguration()
config.planeDetection = [.horizontal, .vertical]

// Enable scene reconstruction (LiDAR devices)
if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
    config.sceneReconstruction = .mesh
}

// Enable environment texturing for realistic reflections
config.environmentTexturing = .automatic

arView.session.run(config)
```

### 3.2 Visualizing Detected Planes

```swift
// Using ARCoachingOverlay to guide users
let coachingOverlay = ARCoachingOverlayView()
coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
coachingOverlay.session = arView.session
coachingOverlay.goal = .horizontalPlane  // or .verticalPlane, .anyPlane
arView.addSubview(coachingOverlay)
```

### 3.3 People Occlusion

People occlusion makes 3D objects appear behind real people, creating a more realistic experience.

```swift
let config = ARWorldTrackingConfiguration()

if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
    config.frameSemantics.insert(.personSegmentationWithDepth)
}

arView.session.run(config)

// Enable occlusion in the AR view
arView.environment.sceneUnderstanding.options.insert(.occlusion)
```

### 3.4 Environment Understanding

```swift
// Light estimation (automatically adjusts virtual lighting to match real world)
config.isLightEstimationEnabled = true

// Scene understanding for physics
arView.environment.sceneUnderstanding.options = [
    .occlusion,        // Virtual objects hidden behind real objects
    .physics,          // Virtual objects interact with real surfaces
    .receivesLighting  // Real-world lighting affects virtual objects
]
```

### Level 3 Exercise

Create an AR measurement app:
1. Tap two points on a detected plane.
2. Draw a line between them.
3. Display the measured distance in centimeters.
4. Add a "Reset" button to clear all measurements.

---

## Level 4: Face Tracking and Body Tracking

### 4.1 Face Tracking Setup

Face tracking requires a device with a TrueDepth camera (iPhone X or later, front-facing camera).

```swift
import ARKit
import RealityKit

class FaceTrackingViewController: UIViewController {
    var arView: ARView!

    override func viewDidLoad() {
        super.viewDidLoad()

        arView = ARView(frame: view.bounds)
        view.addSubview(arView)

        // Check if face tracking is supported
        guard ARFaceTrackingConfiguration.isSupported else {
            print("Face tracking not supported on this device")
            return
        }

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        config.maximumNumberOfTrackedFaces = 1

        arView.session.run(config)
    }
}
```

### 4.2 Adding Face Masks/Filters

```swift
// Using ARKit delegate to track face updates
extension FaceTrackingViewController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        for anchor in anchors {
            guard let faceAnchor = anchor as? ARFaceAnchor else { continue }

            // Access blend shapes (facial expressions)
            let smile = faceAnchor.blendShapes[.mouthSmileLeft]?.floatValue ?? 0
            let browUp = faceAnchor.blendShapes[.browInnerUp]?.floatValue ?? 0
            let eyeBlink = faceAnchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0

            // Use these values to animate your 3D content
            print("Smile: \(smile), Brow: \(browUp), Blink: \(eyeBlink)")
        }
    }
}

// Assign the delegate
arView.session.delegate = self
```

### 4.3 Body Tracking

```swift
// Body tracking requires A12 chip or later
guard ARBodyTrackingConfiguration.isSupported else {
    print("Body tracking not supported")
    return
}

let config = ARBodyTrackingConfiguration()
arView.session.run(config)

// In the session delegate
func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
    for anchor in anchors {
        guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }

        let skeleton = bodyAnchor.skeleton
        // Access joint positions
        let hipTransform = skeleton.modelTransform(for: .root)
        let leftHandTransform = skeleton.modelTransform(for: .leftHand)
        let rightHandTransform = skeleton.modelTransform(for: .rightHand)

        // Use transforms to overlay content on body joints
    }
}
```

### 4.4 Building a Face Filter App

```swift
struct FaceFilterARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        guard ARFaceTrackingConfiguration.isSupported else { return arView }

        // Load a face mask model (USDZ with face geometry)
        let faceAnchor = AnchorEntity(.face)

        // Create glasses or hat overlay
        if let glasses = try? ModelEntity.loadModel(named: "glasses") {
            glasses.scale = SIMD3(repeating: 0.01)
            glasses.position = SIMD3(0, 0.02, 0.06)  // Position on face
            faceAnchor.addChild(glasses)
        }

        arView.scene.anchors.append(faceAnchor)

        let config = ARFaceTrackingConfiguration()
        arView.session.run(config)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}
```

### Level 4 Exercise

Build a face filter app with three different filters (e.g., sunglasses, crown, mustache) that the user can switch between using a segmented control.

---

## Level 5: Image and Object Recognition

### 5.1 Image Detection

Detect known 2D images in the real world and overlay AR content on them.

**Step 1:** Add reference images to your asset catalog:
1. Open `Assets.xcassets` in Xcode.
2. Right-click > **New AR Resource Group**.
3. Drag your reference images into the group.
4. Set the **physical size** for each image (important for accurate tracking).

**Step 2:** Configure image detection:

```swift
let config = ARWorldTrackingConfiguration()

// Load reference images from asset catalog
guard let referenceImages = ARReferenceImage.referenceImages(
    inGroupNamed: "AR Resources",
    bundle: nil
) else { return }

config.detectionImages = referenceImages
config.maximumNumberOfTrackedImages = 4

arView.session.run(config)
```

**Step 3:** Respond to detected images:

```swift
// Using AnchorEntity with image target
let imageAnchor = AnchorEntity(.image(group: "AR Resources", name: "poster"))

// Add a 3D video player on top of the detected image
let videoMesh = MeshResource.generatePlane(width: 0.2, depth: 0.15)
let videoMaterial = SimpleMaterial(color: .white, isMetallic: false)
let videoEntity = ModelEntity(mesh: videoMesh, materials: [videoMaterial])
videoEntity.position = SIMD3(0, 0.001, 0)  // Slightly above the image

imageAnchor.addChild(videoEntity)
arView.scene.anchors.append(imageAnchor)
```

### 5.2 Object Detection

Detect 3D objects that have been pre-scanned.

**Scanning objects:**
1. Use the **ARKit Object Scanner** sample app from Apple (available on the Developer portal).
2. Scan the object from multiple angles.
3. Export the `.arobject` file.
4. Add it to your AR Resource Group in the asset catalog.

```swift
let config = ARWorldTrackingConfiguration()

guard let referenceObjects = ARReferenceObject.referenceObjects(
    inGroupNamed: "AR Objects",
    bundle: nil
) else { return }

config.detectionObjects = referenceObjects
arView.session.run(config)
```

### 5.3 Object Capture (LiDAR)

For devices with LiDAR, you can create 3D models from real objects:

```swift
import RealityKit

// Object Capture API (macOS / iOS with LiDAR)
// This creates a photogrammetry session to build a 3D model
let inputFolder = URL(fileURLWithPath: "/path/to/photos")
let outputFile = URL(fileURLWithPath: "/path/to/output.usdz")

let session = try PhotogrammetrySession(
    input: inputFolder,
    configuration: PhotogrammetrySession.Configuration()
)

try session.process(requests: [
    .modelFile(url: outputFile, detail: .medium)
])

// Monitor progress
for try await output in session.outputs {
    switch output {
    case .processingComplete:
        print("Model creation complete!")
    case .requestProgress(let request, let fraction):
        print("Progress: \(fraction * 100)%")
    default:
        break
    }
}
```

### Level 5 Exercise

Create an AR art gallery:
1. Print 3–5 images (or use book covers).
2. Add them as reference images in your project.
3. When the camera detects an image, overlay a 3D model or information card above it.
4. Add a floating "info" button that shows details about the artwork when tapped.

---

## Level 6: Advanced AR Experiences

### 6.1 Multi-User AR (Collaborative Sessions)

```swift
import MultipeerConnectivity

// Set up multipeer connectivity for shared AR
let config = ARWorldTrackingConfiguration()
config.isCollaborationEnabled = true

arView.session.run(config)

// When a user places an object, share the anchor
arView.session.delegate = self

extension ViewController: ARSessionDelegate {
    func session(_ session: ARSession, didOutputCollaborationData data: ARSession.CollaborationData) {
        // Send this data to other users via MultipeerConnectivity
        sendToAllPeers(data)
    }

    func receivedCollaborationData(_ data: ARSession.CollaborationData) {
        // Apply received data from other users
        arView.session.update(with: data)
    }
}
```

### 6.2 Persistent AR (World Maps)

Save and reload AR sessions so objects stay in place across app launches.

```swift
// Save the world map
arView.session.getCurrentWorldMap { worldMap, error in
    guard let map = worldMap else { return }

    let data = try! NSKeyedArchiver.archivedData(
        withRootObject: map,
        requiringSecureCoding: true
    )
    // Save 'data' to disk
    try! data.write(to: worldMapURL)
}

// Restore the world map
let data = try! Data(contentsOf: worldMapURL)
let worldMap = try! NSKeyedUnarchiver.unarchivedObject(
    ofClass: ARWorldMap.self,
    from: data
)!

let config = ARWorldTrackingConfiguration()
config.initialWorldMap = worldMap
arView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
```

### 6.3 Geo-Anchoring (Location-Based AR)

```swift
// Requires iOS 14+, specific supported locations
guard ARGeoTrackingConfiguration.isSupported else { return }

// Check if the current location supports geo-tracking
ARGeoTrackingConfiguration.checkAvailability { available, error in
    guard available else { return }

    let config = ARGeoTrackingConfiguration()
    arView.session.run(config)

    // Create a geo-anchor at a specific coordinate
    let coordinate = CLLocationCoordinate2D(
        latitude: 37.7749,
        longitude: -122.4194
    )
    let geoAnchor = ARGeoAnchor(
        name: "SF Landmark",
        coordinate: coordinate,
        altitude: 10  // meters above sea level
    )
    arView.session.add(anchor: geoAnchor)
}
```

### 6.4 Scene Reconstruction (LiDAR)

```swift
let config = ARWorldTrackingConfiguration()
config.sceneReconstruction = .meshWithClassification

arView.session.run(config)

// Enable mesh visualization for debugging
arView.debugOptions = [.showSceneUnderstanding]

// Access mesh classification
arView.scene.subscribe(to: SceneEvents.Update.self) { event in
    if let meshAnchors = arView.session.currentFrame?.anchors
        .compactMap({ $0 as? ARMeshAnchor }) {
        for meshAnchor in meshAnchors {
            let geometry = meshAnchor.geometry
            // Access vertices, faces, classification
            // Classification: wall, floor, ceiling, table, seat, window, door
        }
    }
}
```

### Level 6 Exercise

Build a "time capsule" AR app:
1. Let users place 3D messages at specific locations.
2. Save the world map so the messages persist.
3. When the app is reopened in the same location, restore the messages.
4. Add a visual "reveal" animation when messages are found.

---

## Level 7: AR with Unity on iOS

Unity is an excellent choice for complex AR experiences, especially games.

### 7.1 Setting Up AR Foundation in Unity

1. Open Unity Hub and create a new **3D (Core)** project.
2. Go to **Window > Package Manager**.
3. Install the following packages:
   - **AR Foundation** (cross-platform AR framework)
   - **Apple ARKit XR Plugin** (iOS-specific implementation)

### 7.2 Creating a Basic Unity AR Scene

1. Delete the default **Main Camera** from the scene.
2. Right-click in the Hierarchy > **XR > AR Session**.
3. Right-click in the Hierarchy > **XR > XR Origin (Mobile AR)**.
4. The XR Origin includes a camera that is tracked by ARKit.

### 7.3 Plane Detection in Unity

```csharp
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;
using System.Collections.Generic;

public class PlaceOnPlane : MonoBehaviour
{
    [SerializeField] private GameObject prefabToPlace;
    private ARRaycastManager raycastManager;
    private List<ARRaycastHit> hits = new List<ARRaycastHit>();

    void Awake()
    {
        raycastManager = GetComponent<ARRaycastManager>();
    }

    void Update()
    {
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);
            if (touch.phase == TouchPhase.Began)
            {
                if (raycastManager.Raycast(touch.position, hits, TrackableTypes.PlaneWithinPolygon))
                {
                    Pose hitPose = hits[0].pose;
                    Instantiate(prefabToPlace, hitPose.position, hitPose.rotation);
                }
            }
        }
    }
}
```

### 7.4 Building for iOS from Unity

1. Go to **File > Build Settings**.
2. Select **iOS** and click **Switch Platform**.
3. Click **Player Settings** and configure:
   - Bundle Identifier
   - Camera Usage Description
   - Minimum iOS version (14.0+ recommended)
4. Click **Build** to generate an Xcode project.
5. Open the Xcode project and run on your device.

### Level 7 Exercise

Build an AR bowling game in Unity:
1. Detect a horizontal plane for the bowling lane.
2. Place bowling pins on the plane.
3. Let the user swipe to roll a ball.
4. Add physics so pins get knocked over realistically.
5. Display a score.

---

## Level 8: visionOS and Spatial Computing

### 8.1 Introduction to visionOS

visionOS is Apple's operating system for Apple Vision Pro, enabling fully immersive spatial computing experiences. While different from iOS AR, the skills transfer directly.

### 8.2 Creating a visionOS App

```swift
import SwiftUI
import RealityKit

@main
struct MyVisionApp: App {
    var body: some Scene {
        // Window-based content
        WindowGroup {
            ContentView()
        }

        // Volumetric content (3D objects in shared space)
        WindowGroup(id: "volume") {
            VolumetricView()
        }
        .windowStyle(.volumetric)

        // Immersive space (full immersion)
        ImmersiveSpace(id: "immersive") {
            ImmersiveView()
        }
    }
}

struct VolumetricView: View {
    var body: some View {
        RealityView { content in
            let sphere = ModelEntity(
                mesh: .generateSphere(radius: 0.1),
                materials: [SimpleMaterial(color: .blue, isMetallic: true)]
            )
            content.add(sphere)
        }
    }
}
```

### 8.3 Hand Tracking and Eye Tracking

```swift
import ARKit
import RealityKit

struct HandTrackingView: View {
    var body: some View {
        RealityView { content in
            // Hand tracking is automatic in visionOS
            // Use SpatialTapGesture for "look and tap" interaction
        }
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    let tappedEntity = value.entity
                    // Handle tap on entity
                }
        )
    }
}
```

### Level 8 Exercise

Design (on paper or in Xcode's visionOS simulator) a spatial learning app:
1. A floating 3D model of the solar system.
2. Users can tap on planets to see information.
3. Planets orbit with animations.
4. Include a volumetric window showing planet details.

---

## Resources and Next Steps

### Official Apple Resources

| Resource | Description | Link |
|---|---|---|
| ARKit Documentation | Complete API reference | [developer.apple.com/documentation/arkit](https://developer.apple.com/documentation/arkit) |
| RealityKit Documentation | 3D rendering for AR | [developer.apple.com/documentation/realitykit](https://developer.apple.com/documentation/realitykit) |
| Apple AR Quick Look Gallery | Free USDZ models | [developer.apple.com/augmented-reality/quick-look](https://developer.apple.com/augmented-reality/quick-look/) |
| WWDC AR Sessions | Conference videos | [developer.apple.com/wwdc](https://developer.apple.com/wwdc) |
| visionOS Documentation | Spatial computing | [developer.apple.com/visionos](https://developer.apple.com/visionos) |

### Community Resources

| Resource | Description | Link |
|---|---|---|
| Hacking with Swift: AR tutorials | SwiftUI + AR projects | [hackingwithswift.com/quick-start/swiftui](https://www.hackingwithswift.com/quick-start/swiftui) |
| Reality School (YouTube) | Video tutorials for RealityKit | Search "Reality School" on YouTube |
| r/ARKit (Reddit) | Community discussions | reddit.com/r/ARKit |

### Learning Path Summary

```
Beginner:
  → Place basic 3D shapes in AR
  → Load USDZ models
  → Tap-to-place interaction

Intermediate:
  → Plane detection and visualization
  → Face tracking and filters
  → Image recognition
  → Physics and animations

Advanced:
  → Multi-user collaborative AR
  → Persistent world maps
  → Geo-anchored experiences
  → Scene reconstruction (LiDAR)
  → Unity AR Foundation
  → visionOS spatial computing
```

---

*Document generated on April 2026. ARKit and RealityKit APIs may evolve — always consult the latest Apple documentation.*
