import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/employee.dart';

abstract class LocalEmployeeState extends Equatable {
  final List<EmployeeEntity> ? employee;

  const LocalEmployeeState({this.employee});

  @override
  List<Object> get props => [employee!];
}

class LocalEmployeeLoading extends LocalEmployeeState {
  const LocalEmployeeLoading();
}

class LocalEmployeeDone extends LocalEmployeeState {

  const LocalEmployeeDone(List<EmployeeEntity> employee) : super(employee: employee);
}