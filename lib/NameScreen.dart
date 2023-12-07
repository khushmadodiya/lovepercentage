

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:love/showResult.dart';
import 'package:love/showresultavailable.dart';

import 'globle.dart';
String cal="";

class NameScreen extends StatefulWidget{
  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {


  final malenameTextEditingController = TextEditingController();
  final maledatelTextEditingController = TextEditingController();
  final femaleTextEditingController = TextEditingController();
  final femaledateTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  bool show =false;
  final _formkey =GlobalKey<FormState>();
  Future<void> _submit()async{
    var resss;
    if(_formkey.currentState!.validate()) {
      try{
        var uri = "http://localhost/love/check_already_exist.php";
        resss = await http.post(Uri.parse(uri),
            body: {
              "male":malenameTextEditingController.text.trim(),
              "maledate":maledatelTextEditingController.text.trim(),
              "female":femaleTextEditingController.text.trim(),
              "femaledate":femaledateTextEditingController.text.trim(),

            });
        var response = jsonDecode(resss.body);
        // print(response["result"]);
        // print(response["success"]);
        if(response["success"]=="true"){
          per = response["result"];
          print(per);
          if(per!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>showResultA()));
          Fluttertoast.showToast(msg: "repeated couple name");}
          else{
            Fluttertoast.showToast(msg: 'arr is null');
          }

        }
        else{
          print("else part");
          double val = value();
          cal = val.toString();
          try{
            var uri = "http://localhost/love/insert_couple.php";
            var res = await http.post(Uri.parse(uri),
                body: {
                  "male":malenameTextEditingController.text.trim(),
                  "maledate":maledatelTextEditingController.text.trim(),
                  "female":femaleTextEditingController.text.trim(),
                  "femaledate":femaledateTextEditingController.text.trim(),
                  "per":cal,
                });
            var response = jsonDecode(res.body);
            print(response["success"]);
            if(response["success"]=="true"){
              // per = response["result"];
              // print(per);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>showResult()));
              Fluttertoast.showToast(msg: "inserted");
            }
            else{
              Fluttertoast.showToast(msg: "eroor");
            }

          }
          catch(e){
            Fluttertoast.showToast(msg: "errrrrrr$e");
            print(e);
          }
        }

      }
      catch(e){
        Fluttertoast.showToast(msg: "error on email$e");
        print(e);
        print("Raw response: ${resss.body}");
      }


    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,

        body: Center(
          child: Container(
            width: kIsWeb ? MediaQuery.of(context).size.width/2.1:MediaQuery.of(context).size.width,
            child: ListView(
              // padding: EdgeInsets.all(10),
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(40,20,40,20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key:_formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Male",
                                hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                                filled: true,
                                fillColor:Colors.black,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none
                                    )
                                ),
                                prefixIcon: Icon(Icons.person,color:Colors.amber.shade400,),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text==null || text.isEmpty){
                                  return 'Name can\'t be empty';
                                }
                                if(text.length<2){
                                  return 'Please Enter a valid Name';
                                }
                                if(text.length>49){
                                  return 'Name can\'t be greater than 50';
                                }
                              },
                              onChanged: (text)=>setState(() {
                                malenameTextEditingController.text =text;
                                setState(() {
                                  cal ="";
                                });
                              }),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: maledatelTextEditingController,
                              readOnly: true,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Male DOB",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                                filled: true,
                                fillColor: Colors.black,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none
                                    )
                                ),
                                prefixIcon: Icon(Icons.date_range,color:Colors.amber.shade400),
                              ),
                              onTap: ()async{
                                DateTime? datepicker = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050),
                                );
                                var date = "${datepicker?.day} - ${datepicker?.month} - ${datepicker?.year}";
                                print(date);
                                maledatelTextEditingController.text = date;


                              },
                            ),
                            Image.asset("assets/images/love.png",width: 150,),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Female",
                                hintStyle: TextStyle(color: Colors.white,fontSize: 20),
                                filled: true,
                                fillColor: Colors.black,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none
                                    )
                                ),
                                prefixIcon:  Icon(Icons.person,color: Colors.amber.shade400,),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text){
                                if(text==null || text.isEmpty){
                                  return 'Name can\'t be empty';
                                }
                                if(text.length<2){
                                  return 'Please Enter a valid Name';
                                }
                                if(text.length>49){
                                  return 'Name can\'t be greater than 50';
                                }
                              },
                              onChanged: (text)=>setState(() {
                                femaleTextEditingController.text =text;
                              }),
                            ),SizedBox(height: 15,),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: femaledateTextEditingController,
                              readOnly: true,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Female DOB",
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                ),
                                filled: true,
                                fillColor: Colors.black,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none
                                    )
                                ),
                                prefixIcon: Icon(Icons.date_range,color:Colors.amber.shade400),
                              ),
                              onTap: ()async{
                                DateTime? datepicker = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050),
                                );
                                var date = "${datepicker?.day} - ${datepicker?.month} - ${datepicker?.year}";
                                print(date);
                                femaledateTextEditingController.text = date;


                              },
                            ),
                            SizedBox(height: 20,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.amber.shade400,
                                  onPrimary:Colors.black ,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),

                                  ),
                                  minimumSize: Size(double.infinity, 50)

                              ),
                              onPressed: (){
                                _submit();

                              }, child: Text("Submit"),


                            )


                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );

  }

}