import SwiftUI

struct ScanHistoryView: View {
    @State private var scanHistory: [ScannedItem] = ScannerUtility.shared.getHistory()
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            List {
                if scanHistory.isEmpty {
                    Text("No scan history available")
                        .foregroundColor(.gray)
                        .italic()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else {
                    ForEach(scanHistory.indices, id: \.self) { index in
                        ScanHistoryItemView(item: scanHistory[index])
                    }
                }
            }
            .navigationTitle("Scan History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        ScannerUtility.shared.clearHistory()
                        refreshHistory()
                    }) {
                        Text("Clear")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        refreshHistory()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .refreshable {
                await refreshHistoryAsync()
            }
        }
        .onAppear {
            refreshHistory()
        }
    }
    
    private func refreshHistory() {
        scanHistory = ScannerUtility.shared.getHistory()
    }
    
    private func refreshHistoryAsync() async {
        isRefreshing = true
        // Simulate async refresh
        try? await Task.sleep(nanoseconds: 500_000_000)
        scanHistory = ScannerUtility.shared.getHistory()
        isRefreshing = false
    }
}

struct ScanHistoryItemView: View {
    let item: ScannedItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: iconForCodeType(item.type))
                    .foregroundColor(colorForCodeType(item.type))
                
                Text(titleForCodeType(item.type))
                    .font(.headline)
                
                Spacer()
                
                Text(formattedDate(item.timestamp))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Text(item.code)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let formattedCode = formattedCode(item) {
                Text(formattedCode)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func iconForCodeType(_ type: ScannerCodeType) -> String {
        switch type {
        case .patientID:
            return "person.fill"
        case .medicationBarcode:
            return "pills.fill"
        case .equipmentCode:
            return "stethoscope"
        case .staffID:
            return "person.badge.shield.checkmark.fill"
        case .roomCode:
            return "door.left.hand.open"
        case .unknown:
            return "questionmark.circle.fill"
        }
    }
    
    private func colorForCodeType(_ type: ScannerCodeType) -> Color {
        switch type {
        case .patientID:
            return .blue
        case .medicationBarcode:
            return .orange
        case .equipmentCode:
            return .purple
        case .staffID:
            return .green
        case .roomCode:
            return .indigo
        case .unknown:
            return .gray
        }
    }
    
    private func titleForCodeType(_ type: ScannerCodeType) -> String {
        switch type {
        case .patientID:
            return "Patient ID"
        case .medicationBarcode:
            return "Medication"
        case .equipmentCode:
            return "Equipment"
        case .staffID:
            return "Staff ID"
        case .roomCode:
            return "Room"
        case .unknown:
            return "Unknown Code"
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formattedCode(_ item: ScannedItem) -> String? {
        switch item.type {
        case .patientID:
            return ScannerUtility.shared.formatPatientID(item.code)
        case .medicationBarcode:
            return ScannerUtility.shared.formatMedicationCode(item.code)
        default:
            return nil
        }
    }
}

struct ScanHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ScanHistoryView()
    }
}

