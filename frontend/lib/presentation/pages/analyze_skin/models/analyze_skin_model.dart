class DetectionResponse {
  final String message;
  final PredictionData predictions;
  final int status;

  DetectionResponse({
    required this.message,
    required this.predictions,
    required this.status,
  });

  factory DetectionResponse.fromJson(Map<String, dynamic> json) {
    return DetectionResponse(
      message: json['message'] ?? '',
      predictions: PredictionData.fromJson(json['predictions'] ?? {}),
      status: json['status'] ?? 0,
    );
  }
}

class PredictionData {
  final List<Prediction> predictions;

  PredictionData({
    required this.predictions,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> predictionsList = json['predictions'] ?? [];
    final List<Prediction> parsedPredictions = predictionsList
        .map((prediction) => Prediction.fromJson(prediction))
        .toList();

    return PredictionData(predictions: parsedPredictions);
  }
}

class Prediction {
  final double confidenceLevel;
  final String label;
  final int status;

  Prediction({
    required this.confidenceLevel,
    required this.label,
    required this.status,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      confidenceLevel: json['confidence level'] ?? 0.0,
      label: json['label'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}
