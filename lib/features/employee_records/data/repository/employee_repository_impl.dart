
import '../../domain/entities/employee.dart';
import '../../domain/repository/employee_repository.dart';
import '../data_sources/local/app_database.dart';
import '../models/employee_model.dart';
import'dart:async';
class EmployeeRepositoryImpl implements EmployeeRepository {

  final AppDatabase _appDatabase;

  EmployeeRepositoryImpl(this._appDatabase);



  @override
  FutureOr<List<EmployeeModel>> getSavedEmployee() async {
    return _appDatabase.employeeDAO.getEmployeesList();
  }

  @override
  FutureOr<void> removeEmployee(EmployeeEntity employee) {
    return _appDatabase.employeeDAO.deleteEmployees(EmployeeModel.fromEntity(employee));
  }
  @override
  FutureOr<void> editEmployee(EmployeeEntity employee) {
    return _appDatabase.employeeDAO.updateEmployees(EmployeeModel.fromEntity(employee));
  }

  @override
  FutureOr<void> saveEmployee(EmployeeEntity employee) {
    return _appDatabase.employeeDAO.insertEmployees(EmployeeModel.fromEntity(employee));
  }
}