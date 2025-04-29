import Foundation
import UIKit

enum ScannerCodeType {
    case patientID
    case medicationBarcode
    case equipmentCode
    case staffID
    case roomCode
    case unknown
}

struct ScannedItem {
    let code: String
    let type: ScannerCodeType
    let timestamp: Date
    var additionalInfo: [String: Any]?
}

class ScannerUtility {
    
    // Singleton instance
    static let shared = ScannerUtility()
    
    // History of scanned items
    private var scanHistory: [ScannedItem] = []
    
    // Maximum history items to store
    private let maxHistoryItems = 100
    
    private init() {}
    
    // Determine the type of code that was scanned
    func determineCodeType(from code: String) -> ScannerCodeType {
        if code.hasPrefix("PAT") || code.hasPrefix("P-") {
            return .patientID
        } else if code.hasPrefix("MED") || code.hasPrefix("M-") {
            return .medicationBarcode
        } else if code.hasPrefix("EQ") || code.hasPrefix("E-") {
            return .equipmentCode
        } else if code.hasPrefix("STF") || code.hasPrefix("S-") {
            return .staffID
        } else if code.hasPrefix("RM") || code.hasPrefix("R-") {
            return .roomCode
        } else {
            return .unknown
        }
    }
    
    // Process a scanned code
    func processScannedCode(_ code: String) -> ScannedItem {
        let codeType = determineCodeType(from: code)
        let scannedItem = ScannedItem(
            code: code,
            type: codeType,
            timestamp: Date(),
            additionalInfo: nil
        )
        
        // Add to history
        addToHistory(scannedItem)
        
        // Provide feedback based on code type
        provideFeedback(for: codeType)
        
        return scannedItem
    }
    
    // Add a scanned item to history
    private func addToHistory(_ item: ScannedItem) {
        scanHistory.insert(item, at: 0)
        
        // Trim history if it exceeds the maximum
        if scanHistory.count > maxHistoryItems {
            scanHistory = Array(scanHistory.prefix(maxHistoryItems))
        }
    }
    
    // Get scan history
    func getHistory() -> [ScannedItem] {
        return scanHistory
    }
    
    // Clear scan history
    func clearHistory() {
        scanHistory.removeAll()
    }
    
    // Provide haptic and sound feedback based on code type
    private func provideFeedback(for codeType: ScannerCodeType) {
        // Haptic feedback
        let generator: UINotificationFeedbackGenerator
        
        switch codeType {
        case .patientID, .staffID:
            generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .medicationBarcode:
            generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case .equipmentCode, .roomCode:
            generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .unknown:
            generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
        
        // You could also play different sounds here if needed
    }
    
    // Format patient ID for display
    func formatPatientID(_ patientID: String) -> String {
        // Example: Convert "PAT12345" to "Patient #12345"
        if patientID.hasPrefix("PAT") {
            let id = patientID.dropFirst(3)
            return "Patient #\(id)"
        } else if patientID.hasPrefix("P-") {
            let id = patientID.dropFirst(2)
            return "Patient #\(id)"
        }
        return patientID
    }
    
    // Format medication barcode for display
    func formatMedicationCode(_ medicationCode: String) -> String {
        // Example: Convert "MED-AMOX-500MG" to "Medication: AMOX 500MG"
        if medicationCode.hasPrefix("MED-") {
            let parts = medicationCode.dropFirst(4).split(separator: "-")
            if parts.count >= 2 {
                return "Medication: \(parts[0]) \(parts[1])"
            }
        } else if medicationCode.hasPrefix("M-") {
            let parts = medicationCode.dropFirst(2).split(separator: "-")
            if parts.count >= 2 {
                return "Medication: \(parts[0]) \(parts[1])"
            }
        }
        return medicationCode
    }
    
    // Mock function to fetch patient data from a server
    func fetchPatientData(patientID: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        // In a real app, this would make an API call to your backend
        // For this example, we'll simulate a network delay and return mock data
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            // Mock patient data
            let patientData: [String: Any] = [
                "id": patientID,
                "name": "John Doe",
                "age": 45,
                "room": "301",
                "admissionDate": "2023-05-15",
                "primaryDoctor": "Dr. Smith",
                "allergies": ["Penicillin", "Peanuts"]
            ]
            
            DispatchQueue.main.async {
                completion(.success(patientData))
            }
        }
    }
    
    // Mock function to validate medication against patient
    func validateMedication(medicationCode: String, patientID: String, completion: @escaping (Bool, String) -> Void) {
        // In a real app, this would check if this medication is appropriate for the patient
        // For this example, we'll simulate a validation check
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            // Mock validation logic
            let isValid = true
            let message = "Medication verified for patient \(patientID)"
            
            DispatchQueue.main.async {
                completion(isValid, message)
            }
        }
    }
}

