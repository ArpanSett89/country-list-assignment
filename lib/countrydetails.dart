import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  final countryList;

  CountryDetails({Key? key,required this.countryList,

  }) : super(key: key);
  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {

  @override
  Widget build(BuildContext context) {
    //final index = widget.countryList.length;
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
            // Within the SecondRoute widget
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        title: Text(widget.countryList['name'].toString(),style: TextStyle(fontSize: 20),),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(widget.countryList['emoji'],style: TextStyle(fontSize: 130),),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('NATIVE :  ',style: TextStyle(fontSize: 15)),
                      Text(widget.countryList['native'].toString(),style: TextStyle(fontSize: 12),),
                    ],
                  ),
              

              Row(
                children: [Text('CURRENCY :  ',style: TextStyle(fontSize: 15)),
                  Text(widget.countryList['currency'].toString(),style: TextStyle(fontSize: 12),),
                ],
              ),
              ],),
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
