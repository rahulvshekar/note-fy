//
//  NotePredictionManager.swift
//  note-fy
//
//  Created by Rahul V. Shekar on 27/06/20.
//  Copyright © 2020 Rahul V. Shekar. All rights reserved.
//

import Foundation
import CoreML
import Vision

class NotePredictionManager {

    typealias PredictionCompletionHandler = (Prediction) -> Void

    func infer(cvPixelBuffer: CVPixelBuffer, completionHandler: @escaping PredictionCompletionHandler) {
        guard let noteClassificationModel = try? VNCoreMLModel(for: NoteClassifier().model) else { return }
        let request = VNCoreMLRequest(model: noteClassificationModel, completionHandler: { (finishedRequest, err) in
            guard let results = finishedRequest.results as? [VNClassificationObservation],
                let firstResult = results.first,
                let note = Note(rawValue: firstResult.identifier)
                else { return }
            let prediction = Prediction(note: note, confidence: firstResult.confidence)
            completionHandler(prediction)
        })

        try? VNImageRequestHandler(cvPixelBuffer: cvPixelBuffer, options: [:]).perform([request])
    }

    enum Note: String {

        case fiveHundred = "five-hundred"
        case twoThousand = "two-thousand"
        case other = "other"

    }

    struct Prediction {

        let note: Note
        let confidence: Float

    }

}
