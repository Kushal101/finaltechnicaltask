import 'package:get_it/get_it.dart';
import 'features/employee_records/data/data_sources/local/app_database.dart';
import 'features/employee_records/data/repository/employee_repository_impl.dart';
import 'features/employee_records/domain/repository/employee_repository.dart';
import 'features/employee_records/domain/usecase/get_employee_list.dart';
import 'features/employee_records/domain/usecase/remove_employee.dart';
import 'features/employee_records/domain/usecase/save_employee.dart';
import 'features/employee_records/domain/usecase/update_employee.dart';
import 'features/employee_records/presentation/bloc/local_employee_bloc.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);





  sl.registerSingleton<EmployeeRepository>(
      EmployeeRepositoryImpl(sl())
  );

  //UseCases
  sl.registerSingleton<GetEmployeeListCase>(
      GetEmployeeListCase(sl())
  );

  sl.registerSingleton<SaveEmployeeUseCase>(
      SaveEmployeeUseCase(sl())
  );

  sl.registerSingleton<RemoveEmployeeUseCase>(
      RemoveEmployeeUseCase(sl())
  );

  sl.registerSingleton<UpdateEmployeeUseCase>(
      UpdateEmployeeUseCase(sl())
  );




  sl.registerFactory<LocalEmployeeBloc>(
          ()=> LocalEmployeeBloc(sl(),sl(),sl(),sl())
  );


}