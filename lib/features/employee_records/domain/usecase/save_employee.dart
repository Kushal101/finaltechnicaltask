

import '../../../../core/usecase/usecase.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';
import'dart:async';
class SaveEmployeeUseCase implements UseCase<void,EmployeeEntity>{

  final EmployeeRepository _employeeRepository;

  SaveEmployeeUseCase(this._employeeRepository);

  @override
  FutureOr<void> call({EmployeeEntity ? params}) {
    return _employeeRepository.saveEmployee(params!);
  }

}