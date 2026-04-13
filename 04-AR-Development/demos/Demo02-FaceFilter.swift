// Demo02-FaceFilter.swift
// A basic face filter AR app using SwiftUI, ARKit face tracking, and RealityKit.
//
// WHAT THIS APP DOES:
// - Opens the front-facing (TrueDepth) camera.
// - Detects the user's face in real time.
// - Places 3D objects on facial features (e.g., sunglasses on the eyes,
//   a hat above the head, a nose sphere).
// - Demonstrates how face anchors and blend shapes work.
//
// REQUIREMENTS:
// - Xcode 15+, iOS 16+.
// - A device with a TrueDepth camera (iPhone X or later, iPad Pro 2018+).
// - Add "Privacy - Camera Usage Description" to Info.plist.
//
// HOW TO USE IN CLASS:
// 1. Create a new Xcode project: iOS > App, Interface: SwiftUI, Language: Swift.
// 2. Replace the contents of ContentView.swift with this entire file.
// 3. Add camera usage description to Info.plist.
// 4. Build and run on a physical device with TrueDepth camera.
//
// TEACHER NOTES:
// - Face tracking only works on devices with TrueDepth (front-facing IR camera).
// - This demo uses simple geometric shapes as filters. For more advanced filters,
//   students can import USDZ 3D models.
// - The blend shapes section (mouth open detection) shows how to read facial
//   expressions -- a great hook for student engagement.

import SwiftUI
import RealityKit
import ARKit

// MARK: - ContentView
/// The main view with the AR face tracking display and a toggle for the filter style.
struct ContentView: View {
    /// Tracks which filter style is active.
    @State private var filterStyle: FilterStyle = .sunglasses

    var body: some View {
        ZStack {
            // The AR view fills the screen.
            FaceARViewContainer(filterStyle: $filterStyle)
                .edgesIgnoringSafeArea(.all)

            // Overlay: filter selection buttons at the bottom.
            VStack {
                Spacer()

                HStack(spacing: 20) {
                    FilterButton(title: "Sunglasses", style: .sunglasses, current: $filterStyle)
                    FilterButton(title: "Clown Nose", style: .clownNose, current: $filterStyle)
                    FilterButton(title: "Party Hat", style: .partyHat, current: $filterStyle)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(16)
                .padding(.bottom, 30)
            }
        }
    }
}

// MARK: - FilterStyle
/// An enum representing the available face filter styles.
/// Students can add more cases here to create new filters.
enum FilterStyle: String, CaseIterable {
    case sunglasses = "Sunglasses"
    case clownNose = "Clown Nose"
    case partyHat = "Party Hat"
}

// MARK: - FilterButton
/// A reusable button view for selecting a filter.
struct FilterButton: View {
    let title: String
    let style: FilterStyle
    @Binding var current: FilterStyle

    var body: some View {
        Button(action: {
            current = style
        }) {
            Text(title)
                .font(.caption)
                .fontWeight(current == style ? .bold : .regular)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(current == style ? Color.blue : Color.gray.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

// MARK: - FaceARViewContainer
/// Bridges the ARView for face tracking into SwiftUI.
struct FaceARViewContainer: UIViewRepresentable {
    @Binding var filterStyle: FilterStyle

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // --- Configure face tracking ---
        // ARFaceTrackingConfiguration uses the front TrueDepth camera
        // to detect and track the user's face.
        guard ARFaceTrackingConfiguration.isSupported else {
            // If the device doesn't support face tracking, show a message.
            print("ERROR: Face tracking is not supported on this device.")
            return arView
        }

        let configuration = ARFaceTrackingConfiguration()

        // Enable light estimation so virtual objects match real-world lighting.
        configuration.isLightEstimationEnabled = true

        // Start the AR session.
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        // Set the coordinator as the session delegate so we get face anchor updates.
        arView.session.delegate = context.coordinator

        // Store a reference to the ARView in the coordinator.
        context.coordinator.arView = arView

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // When the filter style changes in SwiftUI, tell the coordinator
        // to rebuild the filter on the next frame.
        context.coordinator.currentFilterStyle = filterStyle
        context.coordinator.needsFilterUpdate = true
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(filterStyle: filterStyle)
    }

    // MARK: - Coordinator
    /// Handles ARSession delegate callbacks for face tracking.
    ///
    /// KEY CONCEPT FOR STUDENTS:
    /// ARKit calls delegate methods whenever it detects or updates a face anchor.
    /// We use these callbacks to position 3D objects on the face.
    class Coordinator: NSObject, ARSessionDelegate {
        var arView: ARView?
        var currentFilterStyle: FilterStyle
        var needsFilterUpdate: Bool = true

        /// The anchor entity that holds our filter objects.
        /// We keep a reference so we can remove/replace it when the filter changes.
        private var faceAnchorEntity: AnchorEntity?

        init(filterStyle: FilterStyle) {
            self.currentFilterStyle = filterStyle
            super.init()
        }

        // MARK: session(_:didUpdate:)
        /// Called every frame when ARKit updates tracked anchors.
        /// This is where we read face data and update our 3D content.
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard let arView = arView else { return }

            for anchor in anchors {
                // Check if this anchor is a face anchor.
                guard let faceAnchor = anchor as? ARFaceAnchor else { continue }

                // --- Rebuild the filter if the style changed ---
                if needsFilterUpdate {
                    needsFilterUpdate = false
                    rebuildFilter(for: faceAnchor, in: arView)
                }

                // --- Read blend shapes (facial expressions) ---
                // Blend shapes are float values (0.0 to 1.0) representing
                // how much a facial feature has moved.
                //
                // EXAMPLE: Detect if the mouth is open.
                if let jawOpen = faceAnchor.blendShapes[.jawOpen] as? Float {
                    if jawOpen > 0.5 {
                        // The user's mouth is wide open!
                        // You could trigger an animation or change here.
                        // For now, we just print (uncomment to test):
                        // print("Mouth is open! Value: \(jawOpen)")
                    }
                }

                // EXAMPLE: Detect a smile.
                if let smileLeft = faceAnchor.blendShapes[.mouthSmileLeft] as? Float,
                   let smileRight = faceAnchor.blendShapes[.mouthSmileRight] as? Float {
                    let smileAverage = (smileLeft + smileRight) / 2.0
                    if smileAverage > 0.5 {
                        // The user is smiling!
                        // print("Smile detected! Value: \(smileAverage)")
                    }
                }
            }
        }

        // MARK: rebuildFilter
        /// Removes the old filter and creates new 3D objects based on the selected style.
        private func rebuildFilter(for faceAnchor: ARFaceAnchor, in arView: ARView) {
            // Remove the old filter if it exists.
            if let existing = faceAnchorEntity {
                arView.scene.removeAnchor(existing)
            }

            // Create a new AnchorEntity attached to the face.
            // .face tells RealityKit to automatically track the face's position.
            let faceEntity = AnchorEntity(.face)

            // Build the filter content based on the selected style.
            switch currentFilterStyle {
            case .sunglasses:
                addSunglasses(to: faceEntity)
            case .clownNose:
                addClownNose(to: faceEntity)
            case .partyHat:
                addPartyHat(to: faceEntity)
            }

            // Add the anchor to the scene.
            arView.scene.addAnchor(faceEntity)
            faceAnchorEntity = faceEntity
        }

        // MARK: - Filter Builders
        // Each method creates 3D geometry and positions it relative to the face anchor.
        //
        // COORDINATE SYSTEM:
        // - The face anchor's origin is at the center of the face (between the eyes).
        // - X: positive = right (from the face's perspective)
        // - Y: positive = up
        // - Z: positive = toward the viewer (away from the face)

        /// Creates sunglasses using two flat boxes for lenses and a thin bar for the bridge.
        private func addSunglasses(to parent: AnchorEntity) {
            // --- Left lens ---
            let lensMesh = MeshResource.generateBox(
                size: SIMD3<Float>(0.04, 0.025, 0.005) // width, height, depth
            )
            var lensMaterial = SimpleMaterial()
            lensMaterial.color = .init(tint: .black.withAlphaComponent(0.85))

            let leftLens = ModelEntity(mesh: lensMesh, materials: [lensMaterial])
            // Position: slightly to the right of center (left eye from viewer's perspective),
            // slightly below the anchor center, and slightly forward.
            leftLens.position = SIMD3<Float>(-0.03, 0.01, 0.055)

            // --- Right lens ---
            let rightLens = ModelEntity(mesh: lensMesh, materials: [lensMaterial])
            rightLens.position = SIMD3<Float>(0.03, 0.01, 0.055)

            // --- Bridge (connects the two lenses) ---
            let bridgeMesh = MeshResource.generateBox(
                size: SIMD3<Float>(0.02, 0.005, 0.005)
            )
            var bridgeMaterial = SimpleMaterial()
            bridgeMaterial.color = .init(tint: .darkGray)

            let bridge = ModelEntity(mesh: bridgeMesh, materials: [bridgeMaterial])
            bridge.position = SIMD3<Float>(0.0, 0.01, 0.055)

            // Add all parts to the face anchor.
            parent.addChild(leftLens)
            parent.addChild(rightLens)
            parent.addChild(bridge)
        }

        /// Creates a red sphere on the nose.
        private func addClownNose(to parent: AnchorEntity) {
            let noseMesh = MeshResource.generateSphere(radius: 0.025)
            var noseMaterial = SimpleMaterial()
            noseMaterial.color = .init(tint: .systemRed)

            let nose = ModelEntity(mesh: noseMesh, materials: [noseMaterial])
            // Position the sphere at the tip of the nose.
            // Z is pushed forward so it sits on the nose, not inside the face.
            nose.position = SIMD3<Float>(0.0, -0.02, 0.06)

            parent.addChild(nose)
        }

        /// Creates a cone-like party hat above the head using a cylinder.
        private func addPartyHat(to parent: AnchorEntity) {
            // RealityKit doesn't have a built-in cone, so we use a narrow cylinder
            // to approximate one. For a real cone, import a USDZ model.

            // --- Hat body (tall cylinder, tapered by scaling) ---
            let hatMesh = MeshResource.generateCylinder(
                height: 0.15, radius: 0.04
            )
            var hatMaterial = SimpleMaterial()
            hatMaterial.color = .init(tint: .systemPurple)

            let hat = ModelEntity(mesh: hatMesh, materials: [hatMaterial])
            // Position above the forehead.
            hat.position = SIMD3<Float>(0.0, 0.12, 0.0)
            // Tilt slightly forward to follow the head shape.
            hat.orientation = simd_quatf(angle: -0.15, axis: SIMD3<Float>(1, 0, 0))

            // --- Hat brim (flat cylinder at the base) ---
            let brimMesh = MeshResource.generateCylinder(
                height: 0.005, radius: 0.06
            )
            var brimMaterial = SimpleMaterial()
            brimMaterial.color = .init(tint: .systemYellow)

            let brim = ModelEntity(mesh: brimMesh, materials: [brimMaterial])
            brim.position = SIMD3<Float>(0.0, 0.05, 0.0)

            // --- Small ball on top ---
            let ballMesh = MeshResource.generateSphere(radius: 0.015)
            var ballMaterial = SimpleMaterial()
            ballMaterial.color = .init(tint: .systemYellow)

            let ball = ModelEntity(mesh: ballMesh, materials: [ballMaterial])
            ball.position = SIMD3<Float>(0.0, 0.20, 0.0)

            parent.addChild(hat)
            parent.addChild(brim)
            parent.addChild(ball)
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

// =============================================================================
// KEY CONCEPTS SUMMARY FOR STUDENTS:
//
// 1. ARFaceTrackingConfiguration -- Uses the TrueDepth front camera to detect
//    and track faces. Provides a 3D mesh of the face and "blend shapes"
//    (numerical values for facial expressions).
//
// 2. AnchorEntity(.face) -- A RealityKit anchor that automatically positions
//    itself on the detected face. Any child entities move with the face.
//
// 3. Blend Shapes -- Float values (0.0 to 1.0) for ~50 facial features:
//    .jawOpen, .mouthSmileLeft, .eyeBlinkLeft, .browInnerUp, etc.
//    Full list: https://developer.apple.com/documentation/arkit/arfaceanchor/blendshapelocation
//
// 4. Coordinate System -- The face anchor origin is between the eyes.
//    X = left/right, Y = up/down, Z = toward/away from viewer.
//    Distances are in meters (0.03 = 3 centimeters).
//
// =============================================================================
// EXTENSION ACTIVITIES:
//
// 1. ADD A NEW FILTER:
//    - Add a new case to the FilterStyle enum (e.g., .crown).
//    - Write a new addCrown(to:) method that builds 3D shapes.
//    - Add the case to the switch in rebuildFilter.
//    - Add a new FilterButton in ContentView.
//
// 2. REACT TO EXPRESSIONS:
//    - In session(_:didUpdate:), read .eyeBlinkLeft and .eyeBlinkRight.
//    - If both eyes blink (value > 0.5), change the filter color.
//    - Or detect .tongueOut and show a 3D object when the tongue is visible.
//
// 3. IMPORT A 3D MODEL:
//    - Find a free USDZ model (Apple's AR Quick Look gallery has some).
//    - Add the .usdz file to the Xcode project.
//    - Load it: let model = try! Entity.loadModel(named: "myModel")
//    - Position and add it as a child of the face anchor.
//
// 4. ADD A SCREENSHOT BUTTON:
//    - Add a Button in the SwiftUI overlay.
//    - On tap, call arView.snapshot(saveToHDR: false) { image in ... }
//    - Save the image to the photo library using UIImageWriteToSavedPhotosAlbum.
//
// 5. COLOR BASED ON MOOD:
//    - Calculate a "smile score" from mouthSmileLeft + mouthSmileRight.
//    - Map it to a color gradient (red = not smiling, green = big smile).
//    - Update the filter material color in real time.
// =============================================================================
