//
//  CameraPreviewVC.swift
//  note-fy
//
//  Created by Rahul V. Shekar on 27/06/20.
//  Copyright © 2020 Rahul V. Shekar. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewVC: UIViewController {
    
    @IBOutlet weak var predictedLabel: UILabel!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var iconIV: UIImageView!
    
    let cameraPreviewVM = CameraPreviewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCamera()
    }
    
    private func configureCamera() {
        
        //Start capture session
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        captureSession.startRunning()
        
        // Add input for capture
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let captureInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(captureInput)
        
        // Add preview layer to our view to display the open camera screen
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewView.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        // Add output of capture
        /* Here we set the sample buffer delegate to our viewcontroller whose callback
         will be on a queue named - videoQueue */
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    private func updateLabel(with prediction: NotePredictionManager.Prediction) {
//        predictedLabel.text = prediction.note.name
//        iconIV.image = prediction.note.iconImage
        switch prediction.note {
        case .twoThousand, .fiveHundred:
            if prediction.confidence > 0.95 {
                predictedLabel.text = prediction.note.name
                iconIV.image = prediction.note.iconImage
                prediction.note.utter()
            } else {
                predictedLabel.text = ""
                iconIV.image = nil
            }
        case .other:
            predictedLabel.text = prediction.note.name
            iconIV.image = prediction.note.iconImage
        }
    }
    
}

extension CameraPreviewVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        cameraPreviewVM.handleIncomingFrames(cvPixelBuffer: pixelBuffer, completionHandler: { (prediction) in
            self.updateLabel(with: prediction)
        })
        
    }
    
}



