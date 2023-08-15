
import'dart:async';
import '../../data/models/employee_model.dart';
import '../entities/employee.dart';

abstract class EmployeeRepository {


  // Database methods
  FutureOr<List<EmployeeModel>> getSavedEmployee();


  FutureOr<void> removeEmployee(EmployeeEntity employee);

  FutureOr<void> editEmployee(EmployeeEntity employee);

  FutureOr<void> saveEmployee(EmployeeEntity employee);
}