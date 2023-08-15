import 'package:flutter_bloc/flutter_bloc.dart';


import '../../domain/usecase/get_employee_list.dart';
import '../../domain/usecase/remove_employee.dart';
import '../../domain/usecase/save_employee.dart';
import '../../domain/usecase/update_employee.dart';
import 'local_employee_event.dart';
import 'local_employee_state.dart';

class LocalEmployeeBloc extends Bloc<LocalEmployeeEvent,LocalEmployeeState> {
  final GetEmployeeListCase _employeeListCase;
  final SaveEmployeeUseCase _saveEmployeeUseCase;
  final RemoveEmployeeUseCase _removeEmployeeUseCase;
  final UpdateEmployeeUseCase _updateEmployeeUseCase;

  LocalEmployeeBloc(this._employeeListCase,
      this._updateEmployeeUseCase,
      this._removeEmployeeUseCase,
      this._saveEmployeeUseCase,) : super(const LocalEmployeeLoading()) {
    on <GetEmployeeList>(onGetEmployeeList);
    on <RemoveEmployee>(onRemoveEmployee);
    on <SaveEmployee>(onSaveEmployee);
    on <UpdateEmployee>(onUpdateEmployee);
  }


  void onGetEmployeeList(GetEmployeeList event,
      Emitter<LocalEmployeeState> emit) async {
    final employee = await _employeeListCase();
    emit(LocalEmployeeDone(employee));
  }

  void onRemoveEmployee(RemoveEmployee removeEmployee,
      Emitter<LocalEmployeeState> emit) async {
    await _removeEmployeeUseCase(params: removeEmployee.employee);
    final employee = await _employeeListCase();
    emit(LocalEmployeeDone(employee));
  }

  void onSaveEmployee(SaveEmployee saveEmployee,
      Emitter<LocalEmployeeState> emit) async {
    await _saveEmployeeUseCase(params: saveEmployee.employee);
    final employee = await _employeeListCase();
    emit(LocalEmployeeDone(employee));
  }

  void onUpdateEmployee(UpdateEmployee updateEmployee,
      Emitter<LocalEmployeeState> emit) async {
    await _updateEmployeeUseCase(params: updateEmployee.employee);
    final employee = await _employeeListCase();
    emit(LocalEmployeeDone(employee));
  }
}