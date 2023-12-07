import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:love/globle.dart';

import 'NameScreen.dart';

class showResultA extends StatefulWidget {
  const showResultA({super.key});

  @override
  State<showResultA> createState() => _showResultAState();
}

class _showResultAState extends State<showResultA> {
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
              Center(child: Text("your love percent is ${per}",style: TextStyle(fontSize: 30,color: Colors.white),)),
            ],
          ),
        )
      ),
    );
  }
}
