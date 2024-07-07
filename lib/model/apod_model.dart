class ApodModel {
  final String date;
  final String title;
  final String explanation;
  final String url;

  ApodModel(
      {required this.date,
      required this.title,
      required this.explanation,
      required this.url});

  factory ApodModel.fromJson(Map<String, dynamic> json) {
    return ApodModel(
      date: json['date'],
      title: json['title'],
      explanation: json['explanation'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'title': title,
      'explanation': explanation,
      'url': url,
    };
  }

  factory ApodModel.empty() {
    return ApodModel(
      date: '',
      title: '',
      explanation: '',
      url: '',
    );
  }
}
