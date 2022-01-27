import 'package:cityinfluencers_mobile/models/submissionstatus.dart';

class Submission {
  int? submissionId;
  String url;
  String description;
  SubmissionStatus submissionStatus;

  Submission(
      {this.submissionId,
      required this.url,
      required this.description,
      required this.submissionStatus});

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      submissionId: json['submissionId'],
      url: json['url'],
      description: json['description'],
      submissionStatus: SubmissionStatus.fromJson(json['submissionStatus'])
    );
  }


  Map<String, dynamic> toJson() => {
        'submissionId': submissionId,
        'url': url,
        'description': description,
        'submissionStatus': submissionStatus.toJson()
      };
}
