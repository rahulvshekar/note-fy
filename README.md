# note-fy
A simple iOS app that detects various denominations of the indian currency.

### MVVM architecture
- Uses a Model-View-ViewModel architecture to implement its complete functionality.
- It was helpful to distribute the actions among these 3 groups to maintain a simpler and modular structure to the application.
- A primary view cintroller `CameraPreviewVC` is responsible for configuring the camera and accessing its data. It uses the AV foundation kit for this purpose.
- The same class passes the captured output to a new class `class NotePredictionManager`, which is responsible for the prediction process.
- An enum `Note` is created to standardize the class name.
- A sturct `prediction` is used to store the predicted class name and the confidence of the prediction.
- This struct is accesed by `CameraPreviewVC` using a `PredictionCompletionHandler` to display the predicted note's denomination in the UI label.
- An `UtternaceManager` class is created to speak out the denomination's name as it is predicted.

 `static let shared = UtternaceManager()
  private init() {
    }
  let synthesizer = AVSpeechSynthesizer()`

- An instance of the class is created within itself to initialise the `AVSpeechSynthesizer()` only once.
- Finally all the data is sent back to `CameraPreviewVC` to display it to the user.

### Create ML
- All the ML models were trained using Apple's Create ML tool.
- All the images for the model were shot personally.
- Augmentations were added to improve the data sets range.
- Multiple models were trained, and future models will be trained to detect more denominations.
