

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import 'globle.dart';


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
  String cal="";
  bool show =false;
  final _formkey =GlobalKey<FormState>();
  Future<void> _submit()async{
    var resss;
    if(_formkey.currentState!.validate()) {
      try{
        var uri = "http://192.168.134.238/flutterapi/emailvalidator.php";
        resss = await http.post(Uri.parse(uri),
            body: {
              "male":malenameTextEditingController.text.trim(),
              "female":femaleTextEditingController.text.trim(),

            });
        var response = jsonDecode(resss.body);
        print(response["rowCount"]);
        print(response["success"]);
        if(response["success"]){
          Fluttertoast.showToast(msg: "email Alrady exist");
        }
        else{

          try{
            var uri = "http://192.168.134.238/flutterapi/insert_record.php";
            var res = await http.post(Uri.parse(uri),
                body: {
                  "male":malenameTextEditingController.text.trim(),
                  "female":femaleTextEditingController.text.trim(),
                  "per":passwordTextEditingController.text.trim(),
                });
            var response = jsonDecode(res.body);
            if(response["success"]=="true"){
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

        body: Stack(
          children:[
            Container(
            // width: MediaQuery.of(context).size.width/1.5,
            child: ListView(
              // padding: EdgeInsets.all(10),
              children: [
                // Row(
                //   children: [
                //     Container(
                //       width: MediaQuery.of(context).size.width/2,
                //       child: Image.asset("assets/images/lo.gif"),
                //     ),
                //
                //     Container(
                //       width: MediaQuery.of(context).size.width/2,
                //       child: Image.asset("assets/images/lo.gif"),
                //     ),
                //   ],
                // ),
                Stack(
                  children: [
                    Container(width: MediaQuery.of(context).size.width,
                      child:Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Image.asset("assets/images/lo.gif"),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Image.asset("assets/images/lo.gif"),
                          ),
                        ],
                      ),

                    ),
                    Center(child: Column(
                      children: [
                        SizedBox(height: 50,),
                        Text("$cal %",style: TextStyle(fontSize: 50,color: Colors.white),),
                      ],
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40,30,40,50),
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
                                prefixIcon: Icon(Icons.person,color: Colors.amber.shade400,),
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
                                // _submit();
                                double val = value();
                                setState(() {
                                  cal = val.toString();
                                  show =true;
                                });
                                Timer(Duration(seconds: 5), () {
                                  setState(() {
                                    show = false;
                                  });
                                });
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
            Container(
              child: show? Image.network("https://media.giphy.com/media/mYTOsQlXJGIeYaZklp/giphy.gif"):null,
            )
          ]
        ),

      ),
    );

  }

}