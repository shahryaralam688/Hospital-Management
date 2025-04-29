import SwiftUI

@main
struct HospitalScannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var isShowingScanner = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "qrcode.viewfinder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                
                Text("Hospital Management Scanner")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Scan patient IDs, medication barcodes, or hospital equipment QR codes")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button(action: {
                    isShowingScanner = true
                }) {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Start Scanning")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                // Additional buttons for different scanning purposes
                HStack(spacing: 20) {
                    ScanButton(title: "Patient ID", systemImage: "person.crop.rectangle.fill", color: .green) {
                        isShowingScanner = true
                    }
                    
                    ScanButton(title: "Medication", systemImage: "pills.fill", color: .orange) {
                        isShowingScanner = true
                    }
                    
                    ScanButton(title: "Equipment", systemImage: "stethoscope", color: .purple) {
                        isShowingScanner = true
                    }
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle("Hospital Scanner")
            .sheet(isPresented: $isShowingScanner) {
                ScanningView()
            }
        }
    }
}

struct ScanButton: View {
    var title: String
    var systemImage: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: systemImage)
                    .font(.system(size: 24))
                Text(title)
                    .font(.caption)
            }
            .frame(width: 80, height: 80)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

