# note-fy
A simple iOS app that detects various denominations of the indian currency.

![Demo](/images/demo1.gif)

### MVVM architecture
- Uses a Model-View-ViewModel architecture to implement its complete functionality.
- It was helpful to distribute the actions among these 3 groups to maintain a simpler and modular structure to the application.

### `CameraPreviewVC`
- A primary view cintroller `CameraPreviewVC` is responsible for configuring the camera and accessing its data. It uses the AV foundation kit for this purpose.
- It passes the captured output to a new class `class NotePredictionManager`
- It is also responsible for calling the class `UtternaceManager`
- Responsible for capturing the frames from `AVCaptureOutput` and converting it to type `CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)`
- Updates the UI Label as the `NotePredictionManager` predicts type of currency displaying a related image.

### `NotePredictionManager`
- This is the class that contains the Note prediction model, it is responsible for receiving the `CVPixelBuffer` and passing it to the function `infer(cvPixelBuffer: CVPixelBuffer, completionHandler: @escaping PredictionCompletionHandler)`.
- An enum `Note` is created to standardize the class name.
- A sturct `prediction` is used to store the predicted class name and the confidence of the prediction.
- This struct is accesed by `CameraPreviewVC` using a `PredictionCompletionHandler` to display the predicted note's denomination in the UI label.

### `UtternaceManager`
- An `UtternaceManager` class is created to speak out the denomination's name as it is predicted.

 `static let shared = UtternaceManager()
  private init() {
    }
  let synthesizer = AVSpeechSynthesizer()`

- An instance of the class is created within itself to initialise the `AVSpeechSynthesizer()` only once.
- Finally all the data is sent back to `CameraPreviewVC` to play it to the user.

### `NoteClassifier`
- All the ML models were trained using Apple's Create ML tool.
- All the images for the model were shot personally.
- Augmentations were added to improve the data sets range.
- Multiple models were trained, and future models will be trained to detect more denominations.
- The data used to train the model were shot in real world circumstances.
- Over a thousand pictures were used in total.
- There are only 3 classes currently: "500", "2000", and "Other".
- It works well in natural light or a well, evenly lit room.

### Drawbacks
- It does not work well in the dark.
- It cannot yet properly work in situations that have a lot of glare on the note.
- The contours being on of the main sources of identification for the model, and the notes having very similar contours, makes it hard for the model to distinguish the notes in sitution that cover more than half of the note.

- These drawbacks can how ever be overcome by adding more pictures while training.
- Pictures taken in darker rooms and under more glare from angles can improve the result.
- The issue with contours can be solved by adding pictures with more zoomed in features of each note. This way the model can use other features of the notes to distingish them.

