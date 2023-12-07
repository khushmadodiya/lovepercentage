import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:love/globle.dart';

import 'NameScreen.dart';

class showResult extends StatefulWidget {
  const showResult({super.key});

  @override
  State<showResult> createState() => _showResultState();
}

class _showResultState extends State<showResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Container(
          width: kIsWeb ? MediaQuery.of(context).size.width/2.1:MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width:kIsWeb?MediaQuery.of(context).size.width/4.5: MediaQuery.of(context).size.width/2,
                    child: Image.asset("assets/images/lo.gif"),
                  ),

                  Container(
                    width:kIsWeb?MediaQuery.of(context).size.width/4.5: MediaQuery.of(context).size.width/2,
                    child: Image.asset("assets/images/lo.gif"),
                  ),
                ],
              ),
              SizedBox(height: 200,),
              Center(child: Text("your love percent is $cal",style: TextStyle(fontSize: 30,color: Colors.white),)),
            ],
          ),
        ),
      ),
    );
  }
}
