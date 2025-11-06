import SwiftUI
import SwiftData

struct SettingsView: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var user: User

    @State private var isPasswordVisible: Bool = false
    @State private var image: UIImage? = nil
    @State private var showingImagePicker = false
    @State private var pickerSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showingActionSheet = false

    var body: some View {
        ZStack {
            // background
            Color.background.ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [.clear, .primaryPurpule.opacity(0.1)]),
                           startPoint: .topLeading, endPoint: .bottom)
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {

                    // Image de profil
                    ZStack {
                        Circle()
                            .fill(Color.primaryPurpule.opacity(0.2))
                            .frame(width: 130, height: 130)

                            VStack() {
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 130, height: 130)
                                        .clipShape(Circle())
                                        .contentShape(Circle())
                                } else {
                                    if user.imageProfil != nil {
                                        Image(user.imageProfil!)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 130, height: 130)
                                            .clipShape(Circle())
                                            .contentShape(Circle())
                                    }
                                        else{
                                    Image(systemName: "plus.rectangle.on.rectangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 28, height: 28)
                                        .foregroundColor(.primaryPurpule)
                                    Text("Ajouter")
                                        .buttonLabel()
                                        .foregroundColor(.primaryPurpule)
                                    Text("une image")
                                        .buttonLabel()
                                        .foregroundColor(.primaryPurpule)
                                }
                            }
                        }
                    }
                    .overlay( // ajouter un if pour afficher que si on a deja une image
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.6))
                                .frame(width: 38, height: 38)
                                .glassEffect(.clear.tint(.primaryPurpule.opacity(0.4)))
                            Image(systemName: "pencil").foregroundStyle(Color.primaryPurpule)
                        }.offset(x: 45, y:45)

                    )
                    .onTapGesture { showingActionSheet = true }
                    .actionSheet(isPresented: $showingActionSheet) {
                        ActionSheet(
                            title: Text("Ajouter une image"),
                            buttons: [
                                .default(Text("Prendre une photo")) {
                                    pickerSourceType = .camera
                                    showingImagePicker = true
                                },
                                .default(Text("Choisir depuis la galerie")) {
                                    pickerSourceType = .photoLibrary
                                    showingImagePicker = true
                                },
                                .cancel()
                            ])
                    }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $image, sourceType: pickerSourceType)
                    }
                    .padding(.bottom, 10)

                    // Textfield settings – bind directly to user properties
                    Group {
                        settingsField(title: "Nom", placeholder: "Nom", text: $user.surname)
                        settingsField(title: "Prénom", placeholder: "Prénom", text: $user.name)
                        settingsField(title: "Pseudo", placeholder: "Pseudo", text: $user.pseudo)
                        settingsField(title: "Email", placeholder: "exemple@mail.com", text: $user.mail)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Mot de passe")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            HStack {
                                if isPasswordVisible {
                                    TextField("Mot de passe", text: $user.password)
                                } else {
                                    SecureField("Mot de passe", text: $user.password)
                                }
                                Button(action: {
                                    withAnimation { isPasswordVisible.toggle() }
                                }) {
                                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(12)
                            .background(Color.almostWhite)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                        }
                        let locationBinding = Binding<String>(
                            get: { user.location ?? "" },
                            set: { user.location = $0.isEmpty ? nil : $0 }
                        )
                        settingsField(title: "Ville", placeholder: "Ville", text: locationBinding)
                    }

                    Spacer()
                        .padding(.bottom, 30)
                }
                .padding(24)
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {

                    Spacer()
                    NavigationLink(destination: ConnexionView()) {
                        Image(systemName: "power")
                    }
                    .buttonStyle(.glassProminent)
                    .tint(.red)
                    .accessibilityLabel("Déconnexion")

                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(action: saveAndDismiss) {
                        Label("Valider", systemImage: "checkmark")
                    }.tint(.primaryPurpule)
                }
            }
        }
    }

    private func saveAndDismiss() {
        do {

            try modelContext.save()
            dismiss()
        } catch {

            print("Erreur lors de l'enregistrement: \(error)")
        }
    }

    private func settingsField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            ZStack{
                TextField(placeholder, text: text)
                    .padding(12)
                    .background(Color.almostWhite)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3))

                    )
                HStack(alignment:.center) {
                    Spacer()
                    Image(systemName: "rectangle.and.pencil.and.ellipsis").padding(.horizontal,4)
                }
            }

        }
    }
}

#Preview {
    SettingsView(user: users[0])
}

