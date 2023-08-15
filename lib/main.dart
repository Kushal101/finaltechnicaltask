import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/bloc/local_employee_event.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/pages/employee_list.dart';

import 'config/routes/app_routes.dart';
import 'config/theme/apps_theme.dart';
import 'features/employee_records/presentation/bloc/local_employee_bloc.dart';
import 'injection_container.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalEmployeeBloc>(
        create: (context) => sl()..add(const GetEmployeeList()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
       home: const EmployeeList()
    ));

  }
}