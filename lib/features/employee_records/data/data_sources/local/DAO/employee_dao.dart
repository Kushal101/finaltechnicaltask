
import 'package:floor/floor.dart';

import '../../../models/employee_model.dart';

@dao
abstract class EmployeeDao {

  @Insert()
  Future<void> insertEmployees(EmployeeModel employee);

  @Update()
  Future<void> updateEmployees(EmployeeModel employee);

  @delete
  Future<void> deleteEmployees(EmployeeModel employeeModel);

  @Query('SELECT * FROM employee')
  Future<List<EmployeeModel>> getEmployeesList();
}