// Demo01-PlaceObjects.swift
// A simple tap-to-place AR app using SwiftUI and RealityKit.
//
// WHAT THIS APP DOES:
// - Opens the rear camera in AR mode.
// - Detects horizontal planes (tables, floors).
// - When the user taps the screen, a 3D box is placed at that location in the real world.
// - Each tap places a new box. Boxes persist in the scene.
//
// REQUIREMENTS:
// - Xcode 15+, iOS 16+, physical device with LiDAR or A12+ chip.
// - Add "Privacy - Camera Usage Description" to Info.plist.
//
// HOW TO USE IN CLASS:
// 1. Create a new Xcode project: iOS > App, Interface: SwiftUI, Language: Swift.
// 2. Replace the contents of ContentView.swift with this entire file.
// 3. Add camera usage description to Info.plist.
// 4. Build and run on a physical device.
//
// TEACHER NOTES:
// - Walk through the code section by section before students type it.
// - The key concepts are: ARView, ARSession configuration, raycasting, and AnchorEntity.
// - Students can customize the box color, size, and shape as an extension activity.

import SwiftUI
import RealityKit
import ARKit

// MARK: - Main App Entry Point
// If you are replacing ContentView.swift, your @main App struct should
// already point to ContentView. No changes needed to the App file.

// MARK: - ContentView
/// The main SwiftUI view. It layers a transparent tap gesture over the AR view.
struct ContentView: View {
    var body: some View {
        // The ARViewContainer fills the entire screen.
        // We overlay instructional text at the top.
        ZStack {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Tap on a surface to place an object")
                    .font(.headline)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.top, 50)

                Spacer()
            }
        }
    }
}

// MARK: - ARViewContainer
/// A UIViewRepresentable that bridges RealityKit's ARView into SwiftUI.
///
/// KEY CONCEPT FOR STUDENTS:
/// SwiftUI does not have a native AR view, so we use UIViewRepresentable
/// to wrap a UIKit-based ARView and use it inside SwiftUI.
struct ARViewContainer: UIViewRepresentable {

    // MARK: makeUIView
    /// Called once when the view is first created.
    /// We configure the AR session and add a tap gesture recognizer here.
    func makeUIView(context: Context) -> ARView {
        // 1. Create the ARView. This is the main view that renders the camera
        //    feed and any 3D content we add.
        let arView = ARView(frame: .zero)

        // 2. Configure the AR session.
        //    ARWorldTrackingConfiguration tracks the device's position and
        //    orientation in the real world. It also detects planes.
        let configuration = ARWorldTrackingConfiguration()

        // Enable horizontal plane detection so ARKit finds tables and floors.
        configuration.planeDetection = [.horizontal]

        // Optional: Enable environment texturing for more realistic lighting
        // on placed objects.
        configuration.environmentTexturing = .automatic

        // 3. Start the AR session with our configuration.
        arView.session.run(configuration)

        // 4. Add a tap gesture recognizer.
        //    When the user taps the screen, we want to place an object.
        //    The action method is defined in the Coordinator.
        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        arView.addGestureRecognizer(tapGesture)

        // 5. Optionally enable built-in coaching overlay.
        //    This shows the user an animation prompting them to move the device
        //    to help ARKit understand the environment.
        arView.environment.sceneUnderstanding.options.insert(.occlusion)

        return arView
    }

    // MARK: updateUIView
    /// Called when SwiftUI state changes. We don't need to update anything here.
    func updateUIView(_ uiView: ARView, context: Context) {
        // Nothing to update -- the AR session runs independently.
    }

    // MARK: makeCoordinator
    /// Creates the Coordinator that handles tap gestures.
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    // MARK: - Coordinator
    /// The Coordinator acts as the delegate / target for UIKit gesture recognizers.
    ///
    /// KEY CONCEPT FOR STUDENTS:
    /// In UIViewRepresentable, a Coordinator is the bridge between UIKit events
    /// (like taps) and our SwiftUI/RealityKit code.
    class Coordinator: NSObject {

        /// A counter to give each placed object a unique name (useful for debugging).
        private var objectCount = 0

        /// An array of colors to cycle through for placed objects.
        private let colors: [UIColor] = [
            .systemRed, .systemBlue, .systemGreen,
            .systemYellow, .systemPurple, .systemOrange
        ]

        // MARK: handleTap
        /// Called when the user taps the AR view.
        @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
            // 1. Get a reference to the ARView from the gesture recognizer.
            guard let arView = recognizer.view as? ARView else { return }

            // 2. Get the tap location in the view's coordinate system.
            let tapLocation = recognizer.location(in: arView)

            // 3. Perform a raycast from the tap location into the real world.
            //
            //    RAYCAST EXPLAINED:
            //    A raycast shoots an invisible ray from the 2D screen point into
            //    the 3D world. ARKit checks if that ray hits a detected plane.
            //    If it does, we get back the 3D position where the ray hit.
            let results = arView.raycast(
                from: tapLocation,
                allowing: .estimatedPlane,  // Allow hits on estimated planes
                alignment: .horizontal       // Only hit horizontal surfaces
            )

            // 4. Check if the raycast hit anything.
            guard let firstResult = results.first else {
                // No surface was found at the tap location.
                // This happens if the user taps an area where ARKit
                // hasn't detected a plane yet.
                print("No surface detected at tap location.")
                return
            }

            // 5. Create a 3D object to place.
            //
            //    We use a simple box (ModelEntity) with a colored material.
            //    Students can change the mesh to .generateSphere(radius:),
            //    .generateCylinder(height:radius:), etc.
            let boxSize: Float = 0.05  // 5 centimeters

            // Pick a color from the cycle.
            let color = colors[objectCount % colors.count]

            // Create the mesh (shape) and material (appearance).
            let mesh = MeshResource.generateBox(size: boxSize)
            var material = SimpleMaterial()
            material.color = .init(tint: color)

            // Combine mesh + material into a ModelEntity (a visible 3D object).
            let modelEntity = ModelEntity(mesh: mesh, materials: [material])

            // 6. Create an AnchorEntity at the raycast hit location.
            //
            //    ANCHOR EXPLAINED:
            //    An AnchorEntity ties the 3D object to a real-world position.
            //    Even as the user moves the device, ARKit keeps the object
            //    anchored in the correct spot.
            let anchor = AnchorEntity(world: firstResult.worldTransform)

            // 7. Add the model as a child of the anchor.
            anchor.addChild(modelEntity)

            // 8. Add the anchor to the AR scene.
            arView.scene.addAnchor(anchor)

            // 9. Increment the counter and log for debugging.
            objectCount += 1
            print("Placed object #\(objectCount) at \(firstResult.worldTransform.columns.3)")
        }
    }
}

// MARK: - Preview
/// Xcode preview (will show a blank view since AR requires a device).
#Preview {
    ContentView()
}

// =============================================================================
// EXTENSION ACTIVITIES FOR STUDENTS:
//
// 1. CHANGE THE SHAPE:
//    Replace .generateBox(size:) with .generateSphere(radius: 0.03)
//    or .generateCylinder(height: 0.1, radius: 0.02).
//
// 2. RANDOM COLORS:
//    Use UIColor(hue: CGFloat.random(in: 0...1), saturation: 0.8,
//    brightness: 0.9, alpha: 1.0) for a random color each time.
//
// 3. ADD VERTICAL PLACEMENT:
//    Change .horizontal to .any in the raycast alignment to also
//    place objects on walls.
//
// 4. REMOVE OBJECTS ON TAP:
//    Instead of always placing, check if the tap hits an existing entity
//    using arView.entity(at: tapLocation). If it does, remove it.
//
// 5. ADD ANIMATION:
//    After placing the model, add a scale animation:
//    modelEntity.move(to: Transform(scale: SIMD3<Float>(repeating: 1.2)),
//                     relativeTo: modelEntity, duration: 0.3)
// =============================================================================
