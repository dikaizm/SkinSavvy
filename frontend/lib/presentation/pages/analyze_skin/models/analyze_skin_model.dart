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
  final List<PredictionDetail> details;
  final List<PredictionSummary> summary;

  PredictionData({
    required this.details,
    required this.summary,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> detailsList = json['details'] ?? [];
    final List<PredictionDetail> parsedDetails =
        detailsList.map((detail) => PredictionDetail.fromJson(detail)).toList();

    final List<dynamic> summaryList = json['summary'] ?? [];
    final List<PredictionSummary> parsedSummary =
        summaryList.map((summary) => PredictionSummary.fromJson(summary)).toList();

    return PredictionData(
      details: parsedDetails,
      summary: parsedSummary,
    );
  }
}

class PredictionSummary {
  final String name;
  final double percentage;

  PredictionSummary({
    required this.name,
    required this.percentage,
  });

  factory PredictionSummary.fromJson(Map<String, dynamic> json) {
    return PredictionSummary(
      name: json['name'] ?? '',
      percentage: json['percentage'] ?? 0.0,
    );
  }
}

class PredictionDetail {
  final double confidence;
  final String name;
  final List<Coordinate> coords;

  PredictionDetail({
    required this.confidence,
    required this.name,
    required this.coords,
  });

  factory PredictionDetail.fromJson(Map<String, dynamic> json) {
    final List<dynamic> coordsList = json['coords'] ?? [];
    final List<Coordinate> parsedCoords =
        coordsList.map((coord) => Coordinate.fromJson(coord)).toList();

    return PredictionDetail(
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
