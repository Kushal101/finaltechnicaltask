
import 'package:floor/floor.dart';
import'dart:async';
import '../../../models/employee_model.dart';

@dao
abstract class EmployeeDao {

  @Insert()
  FutureOr<void> insertEmployees(EmployeeModel employee);

  @Update()
  FutureOr<void> updateEmployees(EmployeeModel employee);

  @delete
  FutureOr<void> deleteEmployees(EmployeeModel employeeModel);

  @Query('SELECT * FROM employee')
  FutureOr<List<EmployeeModel>> getEmployeesList();
}