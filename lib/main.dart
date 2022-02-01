import 'package:flutter/material.dart';

import 'inputDecoration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      home: TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String comments = '';
  String error = '';
  bool checked = false;
  final snackBarMsgUnchecked = SnackBar(
    content: Text('Unchecked'),
    duration: Duration (seconds: 3),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test")),
      body: Container(
        child: Center(
          child: RaisedButton(
            color: Colors.redAccent,
            textColor: Colors.white,
            onPressed: () {
              testAlert(context);
            },
            child: Text("popUp"),
          ),
        ),
      ),
    );
  }

  void testAlert(BuildContext context) {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title:
          Center(
            child: Text('Task 1!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  letterSpacing: 2,
                )
            ),
          ),
          content: Wrap(
            children: <Widget>[
              Form(
                key: _formKey,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:textInputDecoration.copyWith(
                                hintText: 'Your Comments',
                                prefixIcon: Icon(Icons.message, ),
                              ),
                              validator: (val) => val!.isEmpty? 'Write your comments' : null ,
                              onChanged: (val){
                                setState(()=> comments = val);

                              }
                          ),

                          SizedBox(height: 20.0),
                          FittedBox(
                            child: Row(
                              children: <Widget>[
                               SizedBox(
                                 height: 24,
                                 width: 24,
                                 child: Checkbox(
                                      value: this.checked,
                                      onChanged: (checked) {
                                        setState(() {
                                          this.checked = checked!;
                                        });
                                      },
                                      activeColor: Colors.green,
                                      focusColor: Colors.white,
                                    ),
                               ),


                                InkWell(
                                  child: Text('This is check box',style: TextStyle(color: Colors.black54,
                                    fontSize: 15,
                                  ),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      checked = !checked;
                                    });
                                  },
                                ),
                                SizedBox(width: 10,),
                                Icon(Icons.hide_source, color: Colors.white,)

                              ],
                            ),
                          ),

                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                  color: Colors.red,
                                  child: Text(
                                    'Close',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      checked = false;
                                    });
                                  }
                              ),
                              SizedBox(width : 10.0),

                              RaisedButton(
                                  color: Colors.green,
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async{
                                    if(_formKey.currentState!.validate() & checked ){
                                      Navigator.of(context).pop();
                                      // showDialog(context: context,
                                      //     builder: (context) => AlertDialog(
                                      //       title: Center(child: Text(comments,style:TextStyle(color:Colors.black87, fontSize: 16, ),)),
                                      //
                                      //       actions: [
                                      //         Row(
                                      //           mainAxisAlignment: MainAxisAlignment.center,
                                      //           children:<Widget> [
                                      //             RaisedButton(
                                      //                 color: Colors.red,
                                      //                 child: Text(
                                      //                   'Close',
                                      //                   style: TextStyle(color: Colors.white),
                                      //                 ),
                                      //                 onPressed: () {
                                      //                   Navigator.of(context).pop();
                                      //                 }
                                      //             ),
                                      //           ],
                                      //         ),
                                      //
                                      //       ],
                                      //     )
                                      // );
                                      final snackBar = SnackBar(
                                        content: Text(comments),
                                        backgroundColor: (Colors.red),
                                        duration: Duration (seconds: 3),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                    }else if (_formKey.currentState!.validate() & !checked ){
                                      final snackBar = SnackBar(
                                        content: const Text('Checkbox is unchecked!'),
                                        backgroundColor: (Colors.red),
                                        duration: Duration (seconds: 3),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                    }else {
                                      final snackBar = SnackBar(
                                        content: const Text('Checkbox and Textfield are empty!'),
                                        backgroundColor: (Colors.red),
                                        duration: Duration (seconds: 3),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }


                                  }
                              ),

                            ],
                          ),

                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),

                        ],
                      );
                    }
                ),
              ),
            ],
          ),

        )
    );
  }
}