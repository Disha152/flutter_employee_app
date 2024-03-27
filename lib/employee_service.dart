import 'dart:convert';
import 'package:flutter/services.dart';
import 'employee.dart';

class EmployeeService {
  Future<List<Employee>> getEmployees() async {
    String employeesJson = await rootBundle.loadString('employees.json');
    List<dynamic> parsedJson = jsonDecode(employeesJson);
    return parsedJson.map((json) => Employee(
      id: json['id'],
      name: json['name'],
      years: json['years'],
      isActive: json['isActive'],
    )).toList();
  }
}
