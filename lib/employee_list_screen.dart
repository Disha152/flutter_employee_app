import 'package:flutter/material.dart';
import 'employee.dart';
import 'employee_service.dart';

class EmployeeListScreen extends StatelessWidget {
  final EmployeeService _employeeService = EmployeeService();

  EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees List',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color:Colors.white),),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeService.getEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Employee employee = snapshot.data![index];
                Color textColor = employee.years > 5 && employee.isActive ? const Color.fromARGB(255, 29, 137, 34) : Colors.black;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: ListTile(
                    title: Text(
                      employee.name,
                      style: TextStyle(color: textColor),
                    ),
                    subtitle: Text(
                      'Years: ${employee.years}',
                      style: TextStyle(color: textColor),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
