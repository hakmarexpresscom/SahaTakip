class DynamicReportRequest {
  String date;
  String store;
  String filledBy;
  List<Question> questions;
  MailRequest mailRequest;

  DynamicReportRequest({
    required this.date,
    required this.store,
    required this.filledBy,
    required this.questions,
    required this.mailRequest,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'store': store,
      'filledBy': filledBy,
      'questions': questions.map((q) => q.toJson()).toList(),
      'mailRequest': mailRequest.toJson(),
    };
  }
}

class Question {
  int id;
  String text;
  String answer;
  int score;

  Question({
    required this.id,
    required this.text,
    required this.answer,
    required this.score,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'answer': answer,
      'score': score,
    };
  }
}

class MailRequest {
  List<String> recipients;
  String subject;
  String htmlContent;
  List<AttachmentData> attachments;

  MailRequest({
    required this.recipients,
    required this.subject,
    required this.htmlContent,
    required this.attachments,
  });

  Map<String, dynamic> toJson() {
    return {
      'recipients': recipients,
      'subject': subject,
      'htmlContent': htmlContent,
      'attachments': attachments.map((a) => a.toJson()).toList(),
    };
  }
}

class AttachmentData {
  String filename;
  String content; // Base64 encoded file
  String type;

  AttachmentData({
    required this.filename,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'content': content,
      'type': type,
    };
  }
}
