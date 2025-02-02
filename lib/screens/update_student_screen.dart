import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_ms/db/database_helper.dart';

import '../models/student.dart';

class UpdateStudentScreen extends StatefulWidget {
  final Student student;
  const UpdateStudentScreen({Key? key, required this.student}) : super(key: key);

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {

  var formKey = GlobalKey<FormState>();
  late String name, date,place, mobile, totalFee, feePaid;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:  Scaffold(
        appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(

                  initialValue: widget.student.name,
                  decoration: InputDecoration(
                      hintText: 'الاسم',
                      labelText: 'الاسم',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'يرجى اضافة الاسم';
                    }

                    name = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  initialValue: widget.student.date,
                  decoration: InputDecoration(
                      hintText: 'التاريخ',
                      labelText: 'التاريخ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'يرجى اضافة التاريخ';
                    }

                    date = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  initialValue: widget.student.place,
                  decoration: InputDecoration(
                      hintText: 'المكان',
                      labelText: 'المكان',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'يرجى اضافة المكان';
                    }

                    place = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                initialValue: widget.student.mobile,
                  decoration: InputDecoration(
                      hintText: 'الهاتف ',
                      labelText: 'رقم الهاتف',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'يرجى اضافة رقم الهاتف ';
                    }

                    mobile = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.student.totalFee.toString(),
                  decoration: InputDecoration(
                      hintText: 'مبلغ الاجمالي',
                      labelText: 'مبلغ الاجمالي ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'يرجى اضافة مبلغ الكلي ';
                    }

                    totalFee = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: '${widget.student.feePaid}',
                  decoration: InputDecoration(
                      hintText: 'مبلغ المدفوعة',
                      labelText: 'المدفوع',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      )
                  ),
                  validator: ( String? text){
                    if( text == null || text.isEmpty){
                      return 'يرجى اضافة مبلغ المدفوعة';
                    }

                    feePaid = text;
                    return null;
                  },
                ),
                const SizedBox(height: 15,),

                ElevatedButton(onPressed: () async{
                  if( formKey.currentState!.validate()){
                    // update record in DB Table

                    Student s = Student(
                      id: widget.student.id,
                      name: name,
                      date: date,
                      place: place,
                      mobile: mobile,
                      totalFee: int.parse(totalFee),
                      feePaid: int.parse(feePaid),
                    );

                    int result = await DatabaseHelper.instance.updateStudent(s);

                    if( result > 0 ){
                      Fluttertoast.showToast(msg: "تم التعديل ", backgroundColor: Colors.green);
                      Navigator.pop(context, 'done');

                    }else{
                      Fluttertoast.showToast(msg: "فشل التعديل ", backgroundColor: Colors.red);

                    }
                  }

                }, child: const Text('التعديل')),


              ],
            ),
          ),
        ),
      ),
    ));
  }
}
