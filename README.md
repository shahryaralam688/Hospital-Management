# Hospital Management Scanning View

This package provides a comprehensive scanning solution for hospital management systems, built with SwiftUI. It allows for scanning various types of barcodes and QR codes commonly used in hospital environments, such as patient IDs, medication barcodes, equipment codes, and more.

## Features

- Camera-based scanning of multiple barcode/QR code formats
- Real-time code detection and processing
- Flashlight toggle support
- Haptic feedback on successful scans
- Scan history tracking
- Detailed patient information display
- Support for different code types (Patient IDs, Medication, Equipment, etc.)
- Clean, modern UI with SwiftUI

## Files Overview

1. **ScanningView.swift** - The main scanning interface with camera preview
2. **HospitalScannerApp.swift** - The main app entry point and home screen
3. **ScannerUtility.swift** - Utility class for processing scanned codes
4. **ScanHistoryView.swift** - View for displaying scan history
5. **PatientDetailView.swift** - Detailed view for patient information

## Requirements

- iOS 14.0+
- Swift 5.3+
- Xcode 12.0+

## Installation

1. Add these files to your SwiftUI project
2. Make sure your app has the camera usage description in Info.plist:
   ```xml
   <key>NSCameraUsageDescription</key>
   <string>We need camera access to scan barcodes and QR codes</string>
   ```
3. Import the necessary frameworks (SwiftUI, AVFoundation)

## Usage

### Basic Implementation

```swift
import SwiftUI

struct ContentView: View {
    @State private var isShowingScanner = false
    
    var body: some View {
        Button("Scan Code") {
            isShowingScanner = true
        }
        .sheet(isPresented: $isShowingScanner) {
            ScanningView()
        }
    }
}
```

### Processing Scanned Codes

The `ScannerUtility` class provides methods for processing different types of codes:

```swift
// When a code is scanned
let scannedItem = ScannerUtility.shared.processScannedCode(scannedCode)

// Check the type of code
switch scannedItem.type {
case .patientID:
    // Navigate to patient details
    navigateToPatientDetails(scannedItem.code)
case .medicationBarcode:
    // Process medication
    processMedication(scannedItem.code)
default:
    // Handle other code types
    handleOtherCodeType(scannedItem)
}
```

## Customization

### Supported Barcode Types

You can customize the supported barcode types in the `ScannerView` class:

```swift
metadataOutput.metadataObjectTypes = [
    .qr,
    .ean8,
    .ean13,
    .pdf417,
    .code128,
    .code39,
    // Add or remove types as needed
]
```

### UI Customization

The UI is built with SwiftUI and can be easily customized by modifying the view components.

## Integration with Backend

To integrate with your hospital management backend:

1. Modify the `fetchPatientData` method in `ScannerUtility.swift` to connect to your API
2. Update the code type detection logic in `determineCodeType` to match your barcode format
3. Implement any additional processing in the `processScannedCode` method

## License

This code is provided as-is under the MIT License.

## Contact

For questions or support, please contact [your contact information].

