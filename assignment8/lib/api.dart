import 'package:dio/dio.dart';
import './Models/Course.dart';
import './Models/Student.dart';

const String localhost = "http://10.0.2.2:1200/";

class CoursesApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));
  Future<List> getAllCourses() async {
    final response = await _dio.get('/getAllCourses');
    return response.data['courses'];
  }

  Future<List> deleteCourseById(String id) async {
    final response = await _dio.post('/deleteCourseById', data: {'id': id});

    return response.data;
  }
}
