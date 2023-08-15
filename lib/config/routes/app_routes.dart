import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/pages/add_employee.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/pages/edit_employee.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/pages/employee_list.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const EmployeeList());

      case '/AddEmployee':
        return _materialRoute(const AddEmployees());

      case '/EditEmployee':
        return _materialRoute(const EditEmployees());


        default:
        return _materialRoute(const EmployeeList());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}