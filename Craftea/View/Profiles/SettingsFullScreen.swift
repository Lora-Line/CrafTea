import SwiftUI

struct SettingsFullScreen: View {
    let user: User
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            SettingsView(user: user)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            HStack(spacing: 8) {
                                Image(systemName: "chevron.backward")
                            }.accessibilityLabel("Retour")
                        }
                    }
                }
        }
    }
}

#Preview {
    SettingsFullScreen(user: users[0])
}
