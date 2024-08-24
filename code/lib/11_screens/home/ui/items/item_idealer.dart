import 'package:flutter/material.dart';
import 'package:idealer/06_main_app_material/ui_constants.dart';

class ItemIdealer extends StatefulWidget {
  const ItemIdealer({Key? key, required this.title, required this.icon, required this.itemClick}) : super(key: key);
  final String title;
  final String icon;
  final VoidCallback itemClick ;
  @override
  State<ItemIdealer> createState() => _ItemIdealerState();
}

class _ItemIdealerState extends State<ItemIdealer> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // background
          onPrimary: Colors.black12, // foreground
        ),
        onPressed: (){
          widget.itemClick.call();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Icon(Icons.person, color: Colors.blue,size: 40,),
            Image.asset(widget.icon, height: 40, width: 40,),
            const SizedBox(height: 12,),
            Text(widget.title, style: const TextStyle(color: blackColor, fontSize: 15,), textAlign: TextAlign.center,),
            const SizedBox(height: 12,),
          ],
        )
    );
  }
}

