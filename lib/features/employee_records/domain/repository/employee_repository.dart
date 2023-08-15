

import '../../data/models/employee_model.dart';
import '../entities/employee.dart';

abstract class EmployeeRepository {


  // Database methods
  Future<List<EmployeeModel>> getSavedEmployee();


  Future<void> removeEmployee(EmployeeEntity employee);

  Future<void> editEmployee(EmployeeEntity employee);

  Future<void> saveEmployee(EmployeeEntity employee);
}