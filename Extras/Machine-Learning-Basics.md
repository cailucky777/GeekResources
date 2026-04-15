# Machine Learning Basics for iOS

You don't need a PhD to ship ML features in your iOS app. Apple provides two friendly tools:

- **Core ML** — *run* ML models inside your app.
- **Create ML** — *train* a simple model without writing ML code.

---

## The Two-Minute Mental Model

A model is a **function**. You give it input (an image, a sentence, an audio clip), it gives you output (a label, a number, another sentence). Training is the process of finding the right parameters for that function.

For a student-scale app, you usually:

1. Find a pre-trained model someone else published.
2. Drop it into Xcode.
3. Call it like any Swift function.

---

## Find a Pre-Trained Model

- [Apple's Core ML Models](https://developer.apple.com/machine-learning/models/) — image classification, pose, depth, and more.
- [Hugging Face Core ML](https://huggingface.co/models?library=coreml) — community-converted models.
- Any `.mlmodel` file works.

---

## Using a Model in an App

1. Drag `YOLOv3Tiny.mlmodel` into Xcode.
2. Xcode auto-generates a Swift class.
3. Call it:

```swift
import CoreML
import Vision
import UIKit

func classify(image: UIImage, completion: @escaping (String) -> Void) {
    let model = try! VNCoreMLModel(for: YOLOv3Tiny().model)
    let request = VNCoreMLRequest(model: model) { req, _ in
        if let results = req.results as? [VNRecognizedObjectObservation],
           let top = results.first?.labels.first {
            completion(top.identifier)
        }
    }
    let handler = VNImageRequestHandler(cgImage: image.cgImage!)
    try? handler.perform([request])
}
```

Now you have "tap a photo → tell me what's in it" in ~30 lines.

---

## Train Your Own with Create ML

Open the **Create ML** app (comes with Xcode). Pick a template:

- **Image Classification** — drop folders of images labeled by folder name.
- **Sound Classification** — audio clips by folder.
- **Text Classification** — CSV of text + label.
- **Activity Classification** — accelerometer sequences.

Click **Train**. Wait. Export `.mlmodel`. Done.

### Dataset Rule of Thumb

- 100 images per class is a weekend starter.
- 1,000+ per class is where real-world accuracy lives.
- Balance your classes — if "cat" has 500 and "dog" has 50, your model will cheat.

---

## Project Ideas

- **Snack Identifier** — photo → "this is a Pocky stick."
- **Bird Call Logger** — record audio → log species.
- **Handwriting Sorter** — classify your own handwritten notes by topic.
- **Posture Coach** — detect slouching via front camera + pose estimation.

---

## Running LLMs On-Device

Apple ships **Apple Intelligence** and supports running small language models locally on recent devices. You can also convert Hugging Face models to Core ML with `coremltools`. This is still early and advanced — worth exploring once you're comfortable with Core ML basics.

---

## Ethics

- Don't train a model on faces or voices without consent.
- Be transparent — if your app makes AI decisions, say so.
- ML models can encode biases from their training data. Test across diverse inputs before shipping.
- For student apps, avoid high-stakes use cases (medical, legal, hiring).

---

## Where to Learn More

- **Apple's Machine Learning guides**: [developer.apple.com/machine-learning/](https://developer.apple.com/machine-learning/)
- **fast.ai** — free practical deep learning course.
- **3Blue1Brown's Neural Networks playlist** — visual intuition for how networks learn.
