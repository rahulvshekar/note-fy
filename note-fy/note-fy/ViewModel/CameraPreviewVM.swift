//
//  CameraPreviewVM.swift
//  note-fy
//
//  Created by Rahul V. Shekar on 27/06/20.
//  Copyright © 2020 Rahul V. Shekar. All rights reserved.
//

import UIKit

class CameraPreviewVM {

    let notePredictionManager = NotePredictionManager()

    func handleIncomingFrames(cvPixelBuffer: CVPixelBuffer, completionHandler: @escaping NotePredictionManager.PredictionCompletionHandler) {

        notePredictionManager.infer(cvPixelBuffer: cvPixelBuffer, completionHandler: { (prediction) in
            DispatchQueue.main.async {
                completionHandler(prediction)
            }
        })
        
    }

}

