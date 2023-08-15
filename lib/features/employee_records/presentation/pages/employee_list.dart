import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:technicsl_task_02/features/employee_records/domain/entities/employee.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/bloc/local_employee_event.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/pages/edit_employee.dart';
import '../../../../injection_container.dart';
import '../bloc/local_employee_bloc.dart';
import '../bloc/local_employee_state.dart';
import '../widgets/employee_tile.dart';

class EmployeeList extends HookWidget {

  const EmployeeList({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LocalEmployeeBloc>()..add(GetEmployeeList()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Stack(children:[

          _buildBody(),
          Positioned(
            top:MediaQuery.of(context).size.height*0.8,
            child:
          bottomContainer(context),)]),
        floatingActionButton: FloatingActionButton.small(onPressed: (){
          _onButtonPressed(context);
          },
          child: Icon(Icons.add),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(

      title: const Text('Employee List', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<LocalEmployeeBloc, LocalEmployeeState>(
      builder: (context, state) {
        if (state is LocalEmployeeLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalEmployeeDone) {
          return _buildEmployeeList(context,state.employee!);
        }
        return Container();
      },
    );
  }

  Widget _buildEmployeeList(context,List<EmployeeEntity> employees) {
    if (employees.isEmpty) {
      return Center(
          child: Image.asset("assets/no_records_found/no_records_found.png")
            
          );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom:50 ),
      shrinkWrap: true,
      itemCount: employees.length,
      itemBuilder: (context, index) {
        final item = employees[index];
        bool _isUndoPressed = false;
        bool isDeleting;
        return  Dismissible(
          key: Key(item.toString()),
          background: Container(
            padding: EdgeInsets.only(right:20),
              color: Colors.red,
          child:const Align(
            alignment: Alignment.centerRight,
            child:
              Icon( Icons.delete_outline_outlined,color:Colors.white))),

          direction: DismissDirection.endToStart,
          onDismissed: (direction) {

             var deleteItem= employees.removeAt(index);
             _onRemoveEmployee(context, deleteItem);
               isDeleting=true;
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: const Text("Employee Data has been deleted"),
            action: SnackBarAction(
            label: "UNDO",
            onPressed: () {
            _isUndoPressed = true;

            isDeleting = false;
            employees.insert(
            index,deleteItem);
           _onAddEmployee(context, deleteItem);
            })));
          },
          child: TileWidget(
          employeeEntity: employees[index],
          isRemovable: true,
            onArticlePressed:(employeeEntity)=> _onTilePressed(context,employeeEntity),


        ));
      }, separatorBuilder: (BuildContext context, int index) {
        return const Divider();
    },
    );


  }
Widget bottomContainer(context){
  return Container(
    padding: EdgeInsets.only(left: 20),
    width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.085,
      color:Theme.of(context).inputDecorationTheme.border?.borderSide.color,
      child:const Align(
        alignment: Alignment.centerLeft,
          child:Text("Swipe left to delete"))
  ) ;
}


  void _onRemoveEmployee(BuildContext context, EmployeeEntity employee) {
    BlocProvider.of<LocalEmployeeBloc>(context).add(RemoveEmployee(employee));
  }

  void _onAddEmployee(BuildContext context, EmployeeEntity employee) {
    BlocProvider.of<LocalEmployeeBloc>(context).add(SaveEmployee(employee));
  }

  void _onButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, '/AddEmployee');
  }
  void _onTilePressed(BuildContext context, EmployeeEntity employeeEntity) {
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditEmployees(employeeEntity: employeeEntity,)));

  }
}
