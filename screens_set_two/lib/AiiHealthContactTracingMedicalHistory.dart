import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AiiHealthContactTracingMedicalHistory extends StatefulWidget {
  @override
  _AiiHealthContactTracingMedicalHistoryState createState() =>
      _AiiHealthContactTracingMedicalHistoryState();
}

class _AiiHealthContactTracingMedicalHistoryState
    extends State<AiiHealthContactTracingMedicalHistory> {
  int conditionNumber;
  var api='https://aiisma-app.appspot.com/';

  List<bool> medicalConditions = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Map contactTracing={
    "diabetes":false,
    "asthama":false,
    "lungdisease":false,
    "kidneytransplant":false,
    "cancertreatment":false,
    "hiv":false,
    "smokinghabit":false,
    "bonemarrowtransplant":false,
    "highbp":false,
    "heartdisease":false,
    "tuberculosis":false,
    "steroidtherapy":false,
    "dialysis":false,
    "liverdisease":false,
    "alcoholhabit":false,
    "noneofthem":false,
    "name":"",
    "dob":"",
    "height":"",
    "weight":"",
    "bloodgroup":"",
    "bmi":"",
    "chest":"",
    "waist":"",
    "biceps":"",
    "id":"wallxc23"
  };


  void submitData()async{
    //dataVitals.push(data[i].name);
   var medcondition={};
   for(int i=0;i<medicalConditions.length;i++){
       medcondition[i]=medicalConditions[i];
   }

   var keys=contactTracing.keys;
   int count=0;
   int i=0;
   for(var key in keys){
      contactTracing[key]=medicalConditions[i];
      i++;
      count++;
      if(count == 16)break;
   }
    Map payload={"account":{"username":"raju.official@gmail.com","password":"1234","mobileNumber":"917667264079"}};
    String body = json.encode(payload);
    print("test44444");
    var url = api+'token';
    var headers = {'Content-Type': 'application/json'};
    var accessToken =await http.post(url,headers:headers,body: body);
    var _accessToken=json.decode(accessToken.body);
    print(_accessToken["accessToken"]);
    String header="bearer "+_accessToken["accessToken"];
    headers = {'Content-Type': 'application/json',"authorization":header};
    url = api+'contacttracing';
    // dataVitals=json.encode(dataVitals);
    body = json.encode(contactTracing);
    var response =await http.post(url,headers:headers,body:body);
    //var body_=json.decode(response.body);
    print(response.body);
    // print(accessToken.body);
  }







  void trackOfMarkedDisease({bool value, int conditionNumber}) {
    setState(() {
      medicalConditions[conditionNumber] = value;
    });
  }

  Widget medicalCondtionRow({String medicalCondition, int conditionNumber}) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          color: Color.fromRGBO(236, 238, 242, 1.0),
          child: Theme(
            data: ThemeData(
                unselectedWidgetColor: Color.fromRGBO(236, 238, 242, 1.0)),
            child: SizedBox(
              height: 16.5,
              width: 16.5,
              child: Checkbox(
                value: medicalConditions[conditionNumber],
                activeColor: Color.fromRGBO(16, 249, 119, 1.0),
                checkColor: Colors.white,
                onChanged: (value) {
                  trackOfMarkedDisease(
                      value: value, conditionNumber: conditionNumber);
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$medicalCondition',
              // textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                // color: Color.fromRGBO(45, 75, 92, 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool numberFieldL = true;
  bool numberFieldR = true;
  var name,
      dob,
      height1,
      weight,
      bloodGroup,
      bmi,
      chest,
      height2,
      waist,
      biceps,
      otherInfo;

  void saveInputData({String inputData, String textValue}) {
    if (inputData == 'Name') {
      name = textValue;
      contactTracing["name"]=name.toString();
    }
    if (inputData == 'Date of Birth') {
      dob = textValue;
      contactTracing["dob"]=dob;
    }
    if (inputData == 'Height') {
      height1 = textValue; //conflict height
      contactTracing["height"]=height1;
    }
    if (inputData == 'Weight') {
      weight = textValue;
      contactTracing["weight"]=weight;
    }
    if (inputData == 'Blood Group') {
      bloodGroup = textValue;
      contactTracing["bloodgroup"]=bloodGroup;
    }
    if (inputData == 'BMI') {
      bmi = textValue;
      contactTracing["bmi"]=bmi;
    }
    if (inputData == 'Chest') {
      chest = textValue;
      contactTracing["chest"]=chest;
    }
    if (inputData == 'Height') {
      height2 = textValue; //conflict height
      contactTracing["height"]=height2;
    }
    if (inputData == 'Waist') {
      waist = textValue;
      contactTracing["waist"]=waist;
    }
    if (inputData == 'Biceps') {
      biceps = textValue;
      contactTracing["biceps"]=biceps;
    }
  }

  Widget textInputRow(
      {String inputLeft,
      bool numberFieldL,
      String inputRight,
      bool numberFieldR}) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 5.0),
              width: 145.0,
              child: TextField(
                onChanged: (textValue) {
                  saveInputData(inputData: inputLeft, textValue: textValue);
                },
                keyboardType:
                    (numberFieldL) ? TextInputType.number : TextInputType.text,
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixStyle: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  filled: true,
                  fillColor: Color.fromRGBO(99, 203, 218, 1.0),
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: '$inputLeft',
                  hintStyle: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(244, 246, 249, 1.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(244, 246, 249, 1.0),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                autofocus: false,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0),
              width: 145.0,
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: (textValue) {
                  saveInputData(inputData: inputRight, textValue: textValue);
                },
                keyboardType:
                    (numberFieldR) ? TextInputType.number : TextInputType.text,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  filled: true,
                  fillColor: Color.fromRGBO(99, 203, 218, 1.0),
                  hintText: '$inputRight',
                  hintStyle: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(244, 246, 249, 1.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(244, 246, 249, 1.0),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                autofocus: false,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Turn off screen rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(120.0, 40.0, 120.0, 10.0),
                child: Image.asset('images/logo.png'),
              ),
              Text(
                '#MyDataMyAsset',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(45, 75, 92, 1.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 20.0),
                // color: Color.fromRGBO(255, 255, 255, 1.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'AiiHealth',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                                color: Color.fromRGBO(45, 75, 92, 1.0),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Contact Tracing - Medical History',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(45, 75, 92, 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        /*buttonRow(
                            buttonLeft: 'Name', buttonRight: 'Date of Birth'),
                        buttonRow(buttonLeft: 'Height', buttonRight: 'Weight'),
                        buttonRow(
                            buttonLeft: 'Blood Group', buttonRight: 'BMI'),*/
                        textInputRow(
                            inputLeft: 'Name',
                            numberFieldL: false,
                            inputRight: 'Date of Birth',
                            numberFieldR: false),
                        textInputRow(
                            inputLeft: 'Height',
                            numberFieldL: true,
                            inputRight: 'Weight',
                            numberFieldR: true),
                        textInputRow(
                            inputLeft: 'Blood Group',
                            numberFieldL: false,
                            inputRight: 'BMI',
                            numberFieldR: true),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5.0, bottom: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Physical Measurements',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        textInputRow(
                            inputLeft: 'Chest',
                            numberFieldL: true,
                            inputRight: 'Height',
                            numberFieldR: true),
                        textInputRow(
                            inputLeft: 'Waist',
                            numberFieldL: true,
                            inputRight: 'Biceps',
                            numberFieldR: true),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5.0, bottom: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Medical History',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                // color: Color.fromRGBO(45, 75, 92, 1.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5.0, bottom: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Do you have or had history of any of the following medical conditions ?',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                // color: Color.fromRGBO(45, 75, 92, 1.0),
                              ),
                            ),
                          ),
                        ),
                        medicalCondtionRow(
                            medicalCondition: 'Diabetes / Renal Failure',
                            conditionNumber: 0),
                        medicalCondtionRow(
                            medicalCondition: 'Asthma', conditionNumber: 1),
                        medicalCondtionRow(
                            medicalCondition: 'Lung Disease',
                            conditionNumber: 2),
                        medicalCondtionRow(
                            medicalCondition: 'Kidney Transplant',
                            conditionNumber: 3),
                        medicalCondtionRow(
                            medicalCondition: 'Cancer Treatment',
                            conditionNumber: 4),
                        medicalCondtionRow(
                            medicalCondition: 'HIV', conditionNumber: 5),
                        medicalCondtionRow(
                            medicalCondition: 'Smoking Habit',
                            conditionNumber: 6),
                        medicalCondtionRow(
                            medicalCondition: 'Bone Marrow Transplant',
                            conditionNumber: 7),
                        medicalCondtionRow(
                            medicalCondition: 'High BP', conditionNumber: 8),
                        medicalCondtionRow(
                            medicalCondition: 'Heart Disease',
                            conditionNumber: 9),
                        medicalCondtionRow(
                            medicalCondition: 'Tuberculosis',
                            conditionNumber: 10),
                        medicalCondtionRow(
                            medicalCondition: 'Steroid Therapy',
                            conditionNumber: 11),
                        medicalCondtionRow(
                            medicalCondition: 'Dialysis', conditionNumber: 12),
                        medicalCondtionRow(
                            medicalCondition: 'Liver Disease',
                            conditionNumber: 13),
                        medicalCondtionRow(
                            medicalCondition: 'Alcohol Habit',
                            conditionNumber: 14),
                        medicalCondtionRow(
                            medicalCondition: 'None of them',
                            conditionNumber: 15),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10.0, left: 25.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Other Medical Info',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 13.0,
                                color: Color.fromRGBO(45, 75, 92, 1.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                           padding: const EdgeInsets.only(
                              left: 25, right: 140),
                            width: 300.0,
                            height: 50.0,
                          margin: EdgeInsets.only(right: 5.0, bottom: 20.0),
                          child: TextField(
                            onChanged: (textValue) {
                              otherInfo = textValue;
                            },
                            textAlign: TextAlign.center,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              suffixStyle: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15.0),
                              filled: true,
                              fillColor: Color.fromRGBO(236, 238, 242, 1.0),
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              hintText: '',
                              hintStyle: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(244, 246, 249, 1.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(244, 246, 249, 1.0),
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                            autofocus: false,
                          ),
                        ),
                        SizedBox(
                          width: 300.0,
                          height: 50.0,
                          child: RaisedButton(
                            padding: EdgeInsets.all(0.0),
                            onPressed: () {submitData();},
                            color: Color.fromRGBO(99, 203, 218, 1.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
