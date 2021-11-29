import 'package:flutter/material.dart';
import 'editCourse.dart';
import 'api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 8',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //
  final CoursesApi api = CoursesApi();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getAllCourses().then((data) {
      setState(() {
        courses = data;
        dbLoaded = true;
      });
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assignment 8"),
        ),
        body: Center(
            child: dbLoaded
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(15.0),
                            children: [
                              ...courses
                                  .map<Widget>(
                                    (courses) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25),
                                      child: TextButton(
                                        onPressed: () => {
                                          Navigator.pop(context),
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditCourse(
                                                          courses['id'],
                                                          courses['courseID'],
                                                          courses['courseName'],
                                                          courses[
                                                              'courseInstructor'],
                                                          courses[
                                                              'courseCredits'],
                                                          courses[
                                                              'dateEntered']))),
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 30,
                                            child: Text(courses['courseName']),
                                          ),
                                          title: Text(
                                            (courses['coursesInstructor'] +
                                                courses['courseCredits']
                                                    .toString()),
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ]),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Database Loading",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      CircularProgressIndicator()
                    ],
                  )));
  }
}
