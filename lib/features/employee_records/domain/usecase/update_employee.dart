import '../../../../core/usecase/usecase.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';
import'dart:async';
class UpdateEmployeeUseCase implements UseCase<void,EmployeeEntity>{

final EmployeeRepository _employeeRepository;

UpdateEmployeeUseCase(this._employeeRepository);

@override
FutureOr<void> call({EmployeeEntity ? params}) {
  return _employeeRepository.editEmployee(params!);
}

}