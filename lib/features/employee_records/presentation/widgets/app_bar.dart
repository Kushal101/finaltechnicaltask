import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget{
  final String title;
const CustomAppBar({required this.title});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 15, bottom: 8, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(
                    height: 5,
                  ),

                ],
              ),
            ],

      ),
    );
  }
}
