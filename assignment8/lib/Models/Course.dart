class Course {
  final String id;
  final String courseID;
  final String courseName;
  final String courseInstructor;
  final String courseCredits;
  final String dateEntered;

  Course._(this.id, this.courseID, this.courseName, this.courseInstructor,
      this.courseCredits, this.dateEntered);

  factory Course.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final courseID = json['courseID'];
    final courseName = json['courseName'];
    final courseInstructor = json['courseInstructor'];
    final courseCredits = json['courseCredits'];
    final dateEntered = json['dateEntered'];

    return Course._(
        id, courseID, courseName, courseInstructor, courseCredits, dateEntered);
  }
}
