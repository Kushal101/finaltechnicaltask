import '../../../../core/usecase/usecase.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';

class UpdateEmployeeUseCase implements UseCase<void,EmployeeEntity>{

final EmployeeRepository _employeeRepository;

UpdateEmployeeUseCase(this._employeeRepository);

@override
Future<void> call({EmployeeEntity ? params}) {
  return _employeeRepository.editEmployee(params!);
}

}