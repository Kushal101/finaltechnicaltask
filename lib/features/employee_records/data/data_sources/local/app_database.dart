import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import '../../models/employee_model.dart';
import 'DAO/employee_dao.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [EmployeeModel])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDAO;
}