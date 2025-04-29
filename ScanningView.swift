import SwiftUI
import AVFoundation

// MARK: - Scanning View
struct ScanningView: View {
    @StateObject private var viewModel = ScanningViewModel()
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            // Camera preview layer
            ScannerView(scannedCode: $viewModel.scannedCode)
                .edgesIgnoringSafeArea(.all)
            
            // Overlay UI elements
            VStack {
                // Header with title and close button
                HStack {
                    Text("Scan Code")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleTorch()
                    }) {
                        Image(systemName: viewModel.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding()
                .background(Color.black.opacity(0.5))
                
                Spacer()
                
                // Scanning frame indicator
                Rectangle()
                    .strokeBorder(viewModel.isScanning ? Color.green : Color.white, lineWidth: 3)
                    .frame(width: 250, height: 250)
                    .background(Color.clear)
                
                Spacer()
                
                // Bottom controls and status
                VStack {
                    if !viewModel.scannedCode.isEmpty {
                        Text("Scanned: \(viewModel.scannedCode)")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(8)
                    }
                    
                    HStack {
                        Button(action: {
                            viewModel.isScanning.toggle()
                        }) {
                            Text(viewModel.isScanning ? "Pause" : "Resume")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            if !viewModel.scannedCode.isEmpty {
                                viewModel.processScannedCode()
                            } else {
                                alertMessage = "No code has been scanned yet"
                                isShowingAlert = true
                            }
                        }) {
                            Text("Process")
                                .foregroundColor(.white)
                                .padding()
                                .background(!viewModel.scannedCode.isEmpty ? Color.green : Color.gray)
                                .cornerRadius(8)
                        }
                        .disabled(viewModel.scannedCode.isEmpty)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.5))
            }
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Scanning Info"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            viewModel.checkCameraPermission()
        }
        .onChange(of: viewModel.scannedCode) { newValue in
            if !newValue.isEmpty {
                // Provide haptic feedback when a code is scanned
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
        }
    }
}

// MARK: - Scanner View (UIViewRepresentable)
struct ScannerView: UIViewRepresentable {
    @Binding var scannedCode: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return view
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return view
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return view
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [
                .qr,
                .ean8,
                .ean13,
                .pdf417,
                .code128,
                .code39,
                .code93,
                .aztec
            ]
        } else {
            return view
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // Store the capture session and preview layer in the coordinator
        context.coordinator.captureSession = captureSession
        context.coordinator.previewLayer = previewLayer
        
        // Start the capture session on a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update UI if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: ScannerView
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?
        
        init(_ parent: ScannerView) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                
                // Send the scanned code back to the parent view
                parent.scannedCode = stringValue
                
                // Optional: Pause scanning after successful scan
                // captureSession?.stopRunning()
            }
        }
        
        func toggleTorch(on: Bool) {
            guard let device = AVCaptureDevice.default(for: .video) else { return }
            
            if device.hasTorch {
                do {
                    try device.lockForConfiguration()
                    device.torchMode = on ? .on : .off
                    device.unlockForConfiguration()
                } catch {
                    print("Torch could not be used: \(error.localizedDescription)")
                }
            }
        }
    }
}

// MARK: - View Model
class ScanningViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published var isScanning = true
    @Published var isTorchOn = false
    @Published var cameraPermissionGranted = false
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.cameraPermissionGranted = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.cameraPermissionGranted = granted
                }
            }
        case .denied, .restricted:
            self.cameraPermissionGranted = false
        @unknown default:
            self.cameraPermissionGranted = false
        }
    }
    
    func toggleTorch() {
        isTorchOn.toggle()
        
        // Access the scanner view's coordinator to toggle the torch
        // This would need to be implemented with a reference to the ScannerView's coordinator
        // For a complete implementation, you would need to pass the coordinator reference
    }
    
    func processScannedCode() {
        // Here you would implement the logic to process the scanned code
        // For example, sending it to a server, looking up a patient record, etc.
        print("Processing code: \(scannedCode)")
        
        // Example: Parse different types of codes
        if scannedCode.hasPrefix("HC") {
            // Process hospital card ID
            print("Hospital Card ID detected")
        } else if scannedCode.hasPrefix("MED") {
            // Process medication code
            print("Medication code detected")
        } else if scannedCode.hasPrefix("PAT") {
            // Process patient ID
            print("Patient ID detected")
        }
        
        // Reset the scanned code after processing if needed
        // scannedCode = ""
    }
}

// MARK: - Preview Provider
struct ScanningView_Previews: PreviewProvider {
    static var previews: some View {
        ScanningView()
    }
}

