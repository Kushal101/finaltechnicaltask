import 'package:equatable/equatable.dart';
import '../../domain/entities/employee.dart';

abstract class LocalEmployeeEvent extends Equatable {
  final EmployeeEntity ? employee;

  const LocalEmployeeEvent({this.employee});

  @override
  List<Object> get props => [employee!];
}

class GetEmployeeList extends LocalEmployeeEvent {
  const GetEmployeeList();
}

class RemoveEmployee extends LocalEmployeeEvent {
  const RemoveEmployee(EmployeeEntity employee) : super(employee: employee);
}

class SaveEmployee extends LocalEmployeeEvent {
  const SaveEmployee(EmployeeEntity employee) : super(employee: employee);
}
  class UpdateEmployee extends LocalEmployeeEvent {
  const UpdateEmployee(EmployeeEntity employee) : super(employee: employee);
}
