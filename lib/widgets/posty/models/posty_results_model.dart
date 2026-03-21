class PostyResultModel {
  String testName = "";
  String subsystemName = "";
  String result = "";
  String failReason = "";

  PostyResultModel(
    this.testName,
    this.subsystemName,
    this.result,
    this.failReason,
  );

  PostyResultModel.fromJson(Map<String, dynamic> json)
    : testName = json['testName'] as String,
      subsystemName = json['subsystemName'] as String,
      result = json['result'] as String,
      failReason = json['failReason'] as String;
}
