import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable{
  final int ? id;
   final String ? name;
   final String ? role;
  final String ? fromDate;
  final String ? toDate;


  const EmployeeEntity({
    this.id,
    this.name,
    this.role,
    this.fromDate,
    this.toDate,
  });

  @override
  List < Object ? > get props {
    return [
      id,
      name,
      role,
      fromDate,
      toDate,

    ];
  }
}