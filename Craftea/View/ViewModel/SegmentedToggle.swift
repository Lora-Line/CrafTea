import SwiftUI

struct SegmentedToggle: View {
    @Namespace private var toggleNS
    @Binding var selection: String
    let options: [String]

    var body: some View {
        HStack() {
            ZStack {
                // Moving selection background
                HStack() {
                    ForEach(options, id: \.self) { option in
                        ZStack {
                            if selection == option {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.primaryPurpule.opacity(0.6))
                                    .matchedGeometryEffect(id: "toggleHighlight", in: toggleNS)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(4)

                // Buttons content
                HStack() {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.2)) {
                                selection = option
                            }
                        }) {
                            Text(option)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(selection == option ? .white : .black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.ultraThinMaterial)
                                            .opacity(0.0001) // keep hit area consistent without visible fill
                                    }
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                        }
                    }
                }
            }
        }
        .frame(height: 36)
        .padding(4)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
    }
}
