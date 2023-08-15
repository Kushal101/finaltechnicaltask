import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technicsl_task_02/features/employee_records/domain/entities/employee.dart';

class TileWidget extends StatelessWidget {
  final EmployeeEntity ? employeeEntity;
  final bool ? isRemovable;
  final void Function(EmployeeEntity employeeEntity) ? onArticlePressed;


  const TileWidget({
    Key ? key,
    this.employeeEntity,
this.onArticlePressed,
    this.isRemovable = false,

  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
onTap: _onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 7, top: 7),
        height: MediaQuery.of(context).size.width / 5,
        child: Row(
          children: [
            _buildTitleAndDescription(),

          ],
        ),
      ),
    );
  }



  Widget _buildTitleAndDescription() {
    return  Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              employeeEntity!.name?? '',
              maxLines : 1,
              overflow : TextOverflow.ellipsis,

            ),

            // Description
            Text(
                  employeeEntity!.role ?? '',
                  maxLines : 1,
                ),



            // Datetime
            Row(
              children: [
                Visibility(
                  visible: employeeEntity!.toDate==null,
                  child:
                  const Text(
                    "From",
                    style: TextStyle(

                    ),
                  ),),
                Text(
                  "${employeeEntity!.fromDate}",
                  style: const TextStyle(

                  ),
                ),
                Visibility(
                  visible: employeeEntity!.toDate!=null,
                  child:
                Text(
                  " - ${employeeEntity!.toDate}",
                  style: const TextStyle(

                  ),
                ),)
              ],
            ),
          ],
        );


  }



  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(employeeEntity!);
    }
  }

}