import 'package:floor/floor.dart';

import '../../domain/entities/employee.dart';

@Entity(tableName:'employee',primaryKeys: ['id'])
class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    int ? id,
    String ? name,
    String ? role,
    String ? fromDate,
    String ? toDate,

  }): super(
    id: id,
    name: name,
    role: role,
    fromDate:fromDate,
    toDate:toDate,
  );

  factory EmployeeModel.fromJson(Map < String, dynamic > map) {
    return EmployeeModel(
      name: map['name'] ?? "",
      role: map['role'] ?? "",
      fromDate: map['fromDate'] ?? "",
      toDate: map['toDate'] ?? "",

    );
  }

  factory EmployeeModel.fromEntity(EmployeeEntity entity) {
    return EmployeeModel(
        id: entity.id,
        name:entity.name,
        role: entity.role,
        fromDate: entity.fromDate,
        toDate: entity.toDate,

    );
  }
}