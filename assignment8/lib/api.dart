import 'package:dio/dio.dart';
import 'Models/Course.dart';
import 'Models/Student.dart';

const String localhost = "http://localhost:1200/";

class CoursesApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));
  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');
    return response.data['courses'];
  }
}
