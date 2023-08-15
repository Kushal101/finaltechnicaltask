import '../../../../core/usecase/usecase.dart';
import '../entities/employee.dart';
import '../repository/employee_repository.dart';

class GetEmployeeListCase implements UseCase<List<EmployeeEntity>,void>{

  final EmployeeRepository _employeeRepository;

  GetEmployeeListCase(this._employeeRepository);

  @override
  Future<List<EmployeeEntity>> call({void params}) {
    return _employeeRepository.getSavedEmployee();
  }

}