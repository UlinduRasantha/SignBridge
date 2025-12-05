// lib/services/sign_model.dart
import 'package:tflite_flutter/tflite_flutter.dart';

/// Update these constants to match your trained model
class SignModel {
  static const int TIMESTEPS = 30; // frames per sequence used in training
  static const int FEATURES = 63; // e.g. 21 landmarks * 3 (x,y,z)
  static const int NUM_CLASSES = 10; // your model's output size

  Interpreter? _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('models/model.tflite');
  }

  /// inputSequence shape: [1, TIMESTEPS, FEATURES]
  /// returns scores length NUM_CLASSES
  List<double> predict(List<List<List<double>>> inputSequence) {
    if (_interpreter == null) {
      throw Exception('Interpreter not loaded. Call loadModel() first.');
    }

    // output container: [1, NUM_CLASSES]
    final output = List.generate(1, (_) => List.filled(NUM_CLASSES, 0.0));

    _interpreter!.run(inputSequence, output);

    // return flattened class scores
    return List<double>.from(output[0]);
  }

  void close() {
    _interpreter?.close();
  }
}
