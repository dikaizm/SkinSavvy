class DetectionResponse {
  final String message;
  final PredictionData predictions;
  final int status;
  final String error;

  DetectionResponse({
    required this.message,
    required this.predictions,
    required this.status,
    this.error = '',
  });

  factory DetectionResponse.fromJson(Map<String, dynamic> json) {
    return DetectionResponse(
      message: json['message'] ?? '',
      predictions: PredictionData.fromJson(json['predictions'] ?? {}),
      status: json['status'] ?? 0,
      error: json['error'] ?? '',
    );
  }
}

class PredictionData {
  final List<Prediction> predictions;
  final List<SkinProblem> skinProblems;

  PredictionData({
    required this.predictions,
    required this.skinProblems,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> predictionsList = json['predictions'] ?? [];
    final List<Prediction> parsedPredictions = predictionsList
        .map((prediction) => Prediction.fromJson(prediction))
        .toList();

    List<SkinProblem> skinProblemsList = [];
    if (parsedPredictions.isNotEmpty) {
      for (var prediction in parsedPredictions) {
        String name = prediction.name;

        var found = false;
        for (var skinProblem in skinProblemsList) {
          if (skinProblem.name == name) {
            found = true;
            break;
          }
        }
        if (!found) {
          skinProblemsList.add(SkinProblem(name: name));
        }
      }
    }

    return PredictionData(
        predictions: parsedPredictions, skinProblems: skinProblemsList);
  }
}

class SkinProblem {
  final String name;

  SkinProblem({
    required this.name,
  });
}

class Prediction {
  final double confidence;
  final String name;
  final List<Coordinate> coords;

  Prediction({
    required this.confidence,
    required this.name,
    required this.coords,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    final List<dynamic> coordsList = json['coords'] ?? [];
    final List<Coordinate> parsedCoords =
        coordsList.map((coord) => Coordinate.fromJson(coord)).toList();

    return Prediction(
      confidence: json['confidence'] ?? 0.0,
      name: json['name'] ?? '',
      coords: parsedCoords,
    );
  }
}

class Coordinate {
  final double x1;
  final double y1;
  final double x2;
  final double y2;

  Coordinate({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      x1: json['x1'] ?? 0.0,
      y1: json['y1'] ?? 0.0,
      x2: json['x2'] ?? 0.0,
      y2: json['y2'] ?? 0.0,
    );
  }
}
