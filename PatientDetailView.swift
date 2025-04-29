import SwiftUI

struct PatientDetailView: View {
    let patientID: String
    
    @State private var patientData: [String: Any]?
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if isLoading {
                    LoadingView()
                } else if let error = errorMessage {
                    ErrorView(message: error)
                } else if let data = patientData {
                    PatientInfoView(data: data)
                }
            }
            .padding()
        }
        .navigationTitle(patientName)
        .onAppear {
            loadPatientData()
        }
    }
    
    private var patientName: String {
        if let data = patientData, let name = data["name"] as? String {
            return name
        }
        return "Patient Details"
    }
    
    private func loadPatientData() {
        isLoading = true
        errorMessage = nil
        
        ScannerUtility.shared.fetchPatientData(patientID: patientID) { result in
            isLoading = false
            
            switch result {
            case .success(let data):
                self.patientData = data
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
            
            Text("Loading patient data...")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding()
    }
}

struct ErrorView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Error Loading Data")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button(action: {
                // Retry action would go here
            }) {
                Text("Retry")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 10)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct PatientInfoView: View {
    let data: [String: Any]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Patient header
            HStack(spacing: 15) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                VStack(alignment: .leading) {
                    Text(data["name"] as? String ?? "Unknown")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Label("ID: \(data["id"] as? String ?? "Unknown")", systemImage: "number")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Label("\(data["age"] as? Int ?? 0) years", systemImage: "calendar")
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            
            // Room information
            InfoSectionView(title: "Room Information", icon: "bed.double.fill") {
                InfoRowView(label: "Room Number", value: data["room"] as? String ?? "Not assigned")
                InfoRowView(label: "Admission Date", value: data["admissionDate"] as? String ?? "Unknown")
                InfoRowView(label: "Primary Doctor", value: data["primaryDoctor"] as? String ?? "Unassigned")
            }
            
            // Medical information
            InfoSectionView(title: "Medical Information", icon: "heart.text.square.fill") {
                if let allergies = data["allergies"] as? [String], !allergies.isEmpty {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Allergies")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        ForEach(allergies, id: \.self) { allergy in
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text(allergy)
                                    .foregroundColor(.primary)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .padding(.vertical, 5)
                } else {
                    InfoRowView(label: "Allergies", value: "None reported")
                }
            }
            
            // Action buttons
            HStack {
                ActionButtonView(title: "Scan Medication", icon: "pills.fill", color: .orange) {
                    // Action to scan medication
                }
                
                ActionButtonView(title: "Update Info", icon: "pencil", color: .blue) {
                    // Action to update patient info
                }
                
                ActionButtonView(title: "View History", icon: "list.bullet.clipboard", color: .green) {
                    // Action to view patient history
                }
            }
        }
    }
}

struct InfoSectionView<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.headline)
            }
            
            Divider()
            
            content
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct InfoRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 120, alignment: .leading)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 5)
    }
}

struct ActionButtonView: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(color)
            .cornerRadius(10)
        }
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PatientDetailView(patientID: "PAT12345")
        }
    }
}

