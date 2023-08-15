

import '../../../../core/usecase/usecase.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';

class SaveEmployeeUseCase implements UseCase<void,EmployeeEntity>{

  final EmployeeRepository _employeeRepository;

  SaveEmployeeUseCase(this._employeeRepository);

  @override
  Future<void> call({EmployeeEntity ? params}) {
    return _employeeRepository.saveEmployee(params!);
  }

}