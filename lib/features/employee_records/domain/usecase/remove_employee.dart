import'dart:async';
import '../../../../core/usecase/usecase.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';

class RemoveEmployeeUseCase implements UseCase<void,EmployeeEntity>{

  final EmployeeRepository _employeeRepository;

  RemoveEmployeeUseCase(this._employeeRepository);

  @override
  FutureOr<void> call({EmployeeEntity ? params}) {
    return _employeeRepository.removeEmployee(params!);
  }

}