import 'main.dart';
import 'package:flutter/material.dart';
import 'api.dart';

class EditCourse extends StatefulWidget {
  final String courseID,
      courseName,
      courseCredits,
      courseInstructor,
      id,
      dateEntered;

  final CoursesApi api = CoursesApi();
  EditCourse(this.id, this.courseCredits, this.courseID, this.courseInstructor,
      this.courseName, this.dateEntered);

  @override
  _EditCourseState createState() => _EditCourseState(
      id, courseID, courseName, courseInstructor, courseCredits, dateEntered);
}

class _EditCourseState extends State<EditCourse> {
  final String id,
      courseID,
      courseName,
      courseInstructor,
      courseCredits,
      dateEntered;

  _EditCourseState(this.id, this.courseID, this.courseName,
      this.courseInstructor, this.courseCredits, this.dateEntered);

  void deleteCourse(id) {
    setState(() {
      widget.api.deleteCourseById(id);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change " + widget.courseName),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  TextFormField(),
                  ElevatedButton(
                      onPressed: () => {deleteCourse(id)}, child: Text(""))
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
