import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:technicsl_task_02/features/employee_records/domain/entities/employee.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/bloc/local_employee_bloc.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/bloc/local_employee_event.dart';
import 'package:technicsl_task_02/features/employee_records/presentation/pages/employee_list.dart';

import '../../../../injection_container.dart';



class EditEmployees extends StatefulWidget {
  final EmployeeEntity? employeeEntity;
  const EditEmployees({Key? key,this.employeeEntity}) : super(key: key);

  @override
  State<EditEmployees> createState() => _EditEmployeeState();

}

class _EditEmployeeState extends State<EditEmployees> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _nextDay=DateTime.now().add(const Duration(days:1));
  DateTime _dayAfterTommorrow=DateTime.now().add(const Duration(days:2));
  DateTime _afterOneWeek=DateTime.now().add(const Duration(days:6 ));

  DateTime? _selectedDate;
  Map<String, List> mySelectedEvents = {};
  String? _toDate;
  String? _selected;
  String? _fromDate;
  bool? isNoDateDialogBoxOpen;
  TextEditingController addEmpNameController = TextEditingController();
  TextEditingController addEmpRoleController = TextEditingController();
  List<String> empRole = [
    "Product Designer",
    "QA Tester",
    "Flutter Developer",
    "Product Owner"
  ];
  @override
  void initState() {



    addEmpNameController.text=widget.employeeEntity!.name!;
    _selected=widget.employeeEntity!.role!;
    _toDate=widget.employeeEntity!.toDate;
    _fromDate=widget.employeeEntity!.fromDate;


    super.initState();
  }
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap:()=>FocusScope.of(context).unfocus(),
        child:BlocProvider(
        create: (_) => sl<LocalEmployeeBloc>(),
    child:Scaffold(
      key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: _buildAppBar(),
          body: _buildAddEmployee(),
        ))
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Edit Employee', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _buildAddEmployee() {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(20),
        height: 40,
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline),
            contentPadding: EdgeInsets.only(top: 15, left: 15),
            hintText: "Employee Name",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .inputDecorationTheme
                      .border!
                      .borderSide
                      .color),
            ),
          ),
          controller: addEmpNameController,
          onChanged: (val) {},
        ),
      ),
      InkWell(
        onTap: () => showModal(context),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          height: 40,
          padding: const EdgeInsets.only(left: 10, right: 20),
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .inputDecorationTheme
                      .border!
                      .borderSide
                      .color),
              borderRadius: BorderRadius.circular(4)),
          child: Row(children: [
            Icon(Icons.work_outline_outlined),
            Container(
              margin: const EdgeInsets.only(
                left: 15,
              ),
              child: Text(_selected ?? "Select Role"),
            ),
            Spacer(),
            Icon(Icons.arrow_drop_down_sharp)
          ]),
        ),
      ),
      Row(children: [
        InkWell(
          onTap: () => showDateCalender(),
          child: Container(
            margin: const EdgeInsets.only(left: 20, bottom: 20),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.only(left: 10, right: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide
                        .color),
                borderRadius: BorderRadius.circular(4)),
            child: Row(children: [
              const Icon(Icons.calendar_month_outlined),
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                ),
                child: Text(_fromDate ?? "Today"),
              ),
            ]),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            isNoDateDialogBoxOpen =true;
            showDateCalender();
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.4,
            padding: const EdgeInsets.only(left: 10, right: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .border!
                        .borderSide
                        .color),
                borderRadius: BorderRadius.circular(4)),
            child: Row(children: [
              const Icon(Icons.calendar_month_outlined),
              Container(
                margin: const EdgeInsets.only(
                  left: 15,
                ),
                child: const Text("No date"),
              ),
            ]),
          ),
        ),
      ]),
      Spacer(),
      Divider(),
      Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(
                onPressed: () {
                Navigator.pop(context);
                },
                child: const Text("Cancel")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                  onPressed: () async{
                    if(addEmpNameController.text.isNotEmpty&&_selected!.isNotEmpty){
                      final addEmp = EmployeeEntity(
                          name: addEmpNameController.text, role: _selected,fromDate:_fromDate ?? DateFormat("dd MMM yyyy").format(_focusedDay),toDate:_toDate ?? "");
                      _onUpdateEmployee(context, addEmp);
                      const EmployeeList().build(context);
                      Navigator.pop(
                        context,
                      );
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill required field")));
                    }

                    Navigator.pop(context,);

                  },
                  child: const Text("Save")),
            ),
          ]))
    ]);
  }

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            alignment: Alignment.center,
            child: ListView.separated(
                itemCount: empRole.length,
                separatorBuilder: (context, int) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Text(empRole[index]),
                      onTap: () {
                        setState(() {
                          _selected = empRole[index];
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }

   showDateCalender() {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              actions: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height*0.85,
                    width: MediaQuery.of(context).size.width,
                    child:
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).padding.vertical),
                          child: Column(children: [
                            Visibility(
                              visible: isNoDateDialogBoxOpen==true,
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState((){
                                              _toDate?.isEmpty;
                                            });

                                          },
                                          child:Text(_toDate??"NoDate")),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState((){
                                              _focusedDay=DateTime.now();
                                              _selectedDate=DateTime.now();
                                            });

                                          },
                                          child:  const Text("Today")),
                                    ),

                                  ]),),
                            Visibility(
                              visible: isNoDateDialogBoxOpen==false,
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState((){
                                              _focusedDay=DateTime.now();
                                              _selectedDate=DateTime.now();
                                            });

                                          },
                                          child:  const Text("Today")),
                                    ),

                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState((){
                                              _focusedDay=_nextDay;
                                              _selectedDate=_nextDay;
                                            });
                                          },
                                          child:  Text("Next ${DateFormat("EEEE").format(_nextDay)}")),
                                    ),
                                  ]),),
                            Visibility(
                              visible: isNoDateDialogBoxOpen==false,
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState((){
                                              _focusedDay=_dayAfterTommorrow;
                                              _selectedDate=_dayAfterTommorrow;
                                            });

                                          },
                                          child: Text("Next ${DateFormat("EEEE").format(_dayAfterTommorrow)}")),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            setState((){
                                              _focusedDay=_afterOneWeek;
                                              _selectedDate=_afterOneWeek;
                                            });
                                          },
                                          child: const Text("After 1 week")),
                                    ),
                                  ]),),
                          ]),
                        ),
                        TableCalendar(
                          headerStyle: const HeaderStyle(
                              formatButtonShowsNext: true,
                              formatButtonVisible: false,
                              titleCentered: true),
                          firstDay: DateTime(2022),

                          lastDay: DateTime(2024),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(_selectedDate, selectedDay)) {
                              setState(() {
                                _selectedDate = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            }
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDate, day);
                          },
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {

                              setState(() {
                                _calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {

                            _focusedDay = focusedDay;
                          },
                          eventLoader: _listOfDayEvents,
                          daysOfWeekHeight: 35.0,
                        ),
                        Spacer(),
                        Divider(),
                        Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child:
                            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              const Icon(Icons.calendar_month_outlined),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child:  Text(_selectedDate==null?"Today":DateFormat('dd MMM yyyy').format(_focusedDay),
                                ),),
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    _focusedDay=DateTime.now();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if(_focusedDay!=DateTime.now()&&isNoDateDialogBoxOpen==false){
                                        setState((){
                                          _fromDate=DateFormat('dd MMM yyyy').format(_focusedDay);
                                        });
                                        Navigator.pop(context);
                                      }
                                      if(_focusedDay!=DateTime.now()&&isNoDateDialogBoxOpen==true){
                                        setState((){
                                          _toDate=DateFormat('dd MMM yyyy').format(_focusedDay);

                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text("Save")),
                              ),
                            ]))
                      ],
                    )
                ),

              ],
            );

          },
        );
      },
    ).whenComplete(() {
      setState(() {
        isNoDateDialogBoxOpen=false;
      });

    });}



  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)] != null) {
      return mySelectedEvents[DateFormat('yyyy-MM-dd').format(dateTime)]!;
    } else {
      return [];
    }
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }


  void _onUpdateEmployee(BuildContext context, EmployeeEntity employee) {
    BlocProvider.of<LocalEmployeeBloc>(context).add(UpdateEmployee(employee));
  }

}

