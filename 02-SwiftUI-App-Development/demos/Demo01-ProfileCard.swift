// ============================================================
// Demo01-ProfileCard.swift
// A student profile card built with SwiftUI.
//
// Concepts demonstrated:
//   - Text, Image (SF Symbols)
//   - VStack, HStack, ZStack
//   - Modifiers: font, foregroundStyle, padding, background,
//     cornerRadius, shadow, frame, clipShape
//
// How to use:
//   1. Create a new Xcode project (App template, SwiftUI).
//   2. Replace the contents of ContentView.swift with this file.
//   3. Run in the simulator or preview canvas.
// ============================================================

import SwiftUI

// MARK: - Profile Data Model
// A simple struct holding the information we want to display.
// In a real app, this might come from a database or API.

struct StudentProfile {
    var name: String
    var grade: String
    var bio: String
    var emailAddress: String
    var phoneNumber: String
    var websiteURL: String
}

// MARK: - Profile Card View

struct ProfileCardView: View {

    // Sample data -- swap in your own details!
    let profile = StudentProfile(
        name: "Alex Johnson",
        grade: "10th Grade",
        bio: "Aspiring app developer and robotics enthusiast. Loves building things that make people smile.",
        emailAddress: "alex@school.edu",
        phoneNumber: "555-0199",
        websiteURL: "alexj.dev"
    )

    var body: some View {

        // ── Outer container: centers the card on screen ──
        ZStack {
            // Background color for the whole screen
            Color(.systemGroupedBackground)
                .ignoresSafeArea()  // Extends behind the status bar and home indicator

            // ── The card itself ──
            VStack(spacing: 16) {

                // ── 1. Avatar / Photo Placeholder ──
                // We use an SF Symbol as a placeholder.
                // In a real app, you could use AsyncImage to load a URL.
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 100))       // Make the icon large
                    .foregroundStyle(.blue)          // Tint it blue
                    .padding(.top, 8)                // A little space above

                // ── 2. Name and Grade ──
                VStack(spacing: 4) {
                    Text(profile.name)
                        .font(.title)                // Large text
                        .fontWeight(.bold)            // Bold weight

                    Text(profile.grade)
                        .font(.subheadline)           // Smaller text
                        .foregroundStyle(.secondary)  // Gray color
                }

                // ── 3. Bio ──
                Text(profile.bio)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)  // Center-align multi-line text
                    .padding(.horizontal, 16)         // Inset from the card edges

                // ── 4. Divider ──
                // A thin horizontal line to separate the bio from contact info.
                Divider()
                    .padding(.horizontal, 24)

                // ── 5. Social / Contact Links Row ──
                HStack(spacing: 32) {

                    // Email icon
                    ContactIcon(
                        systemName: "envelope.fill",
                        label: "Email",
                        color: .blue
                    )

                    // Phone icon
                    ContactIcon(
                        systemName: "phone.fill",
                        label: "Phone",
                        color: .green
                    )

                    // Website / globe icon
                    ContactIcon(
                        systemName: "globe",
                        label: "Web",
                        color: .orange
                    )
                }
                .padding(.bottom, 8)
            }
            // ── Card styling ──
            .padding(24)                                  // Inner padding
            .background(.white)                           // White card background
            .cornerRadius(20)                             // Rounded corners
            .shadow(color: .black.opacity(0.1),           // Subtle shadow
                    radius: 10, x: 0, y: 5)
            .padding(.horizontal, 24)                     // Outer margin from screen edges
        }
    }
}

// MARK: - Contact Icon Component
// A small reusable view for each contact method icon.
// This keeps the main ProfileCardView body clean and readable.

struct ContactIcon: View {
    let systemName: String   // SF Symbol name, e.g. "envelope.fill"
    let label: String        // Text displayed below the icon
    let color: Color         // Tint color for the icon

    var body: some View {
        VStack(spacing: 6) {
            // Circle background behind the icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))   // Light tinted circle
                    .frame(width: 48, height: 48)

                Image(systemName: systemName)
                    .font(.system(size: 20))
                    .foregroundStyle(color)
            }

            // Label text
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Preview
// This lets you see the card in Xcode's canvas without running the app.

#Preview {
    ProfileCardView()
}
