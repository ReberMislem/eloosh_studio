import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_ms/db/database_helper.dart';
import 'package:students_ms/models/student.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  var formKey = GlobalKey<FormState>();
  late String name, place, mobile, totalFee, feePaid;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController totalFeeController = TextEditingController();
  TextEditingController feePaidController = TextEditingController();

  void clearFields() {
    nameController.clear();
    dateController.clear();
    placeController.clear();
    mobileController.clear();
    totalFeeController.clear();
    feePaidController.clear();
  }

  Future<void> exportData() async {
    List<Student> students = await DatabaseHelper.instance.getAllStudents();
    List<Map<String, dynamic>> studentsMap = students.map((s) => s.toMap()).toList();
    String jsonString = jsonEncode(studentsMap);

    Directory? directory = await getExternalStorageDirectory();
    String path = "${directory?.path}/Eloosh_data.json";
    File file = File(path);

    await file.writeAsString(jsonString);

    Fluttertoast.showToast(msg: "تم تصدير البيانات بنجاح إلى $path", backgroundColor: Colors.green);
  }

  Future<void> importData() async {
    Directory? directory = await getExternalStorageDirectory();
    String path = "${directory?.path}/Eloosh_data.json";
    File file = File(path);

    if (await file.exists()) {
      String jsonString = await file.readAsString();
      List<dynamic> studentsMap = jsonDecode(jsonString);

      for (var studentMap in studentsMap) {
        Student student = Student.fromMap(studentMap);
        await DatabaseHelper.instance.insertStudent(student);
      }

      Fluttertoast.showToast(msg: "تم استيراد البيانات بنجاح", backgroundColor: Colors.green);
    } else {
      Fluttertoast.showToast(msg: "ملف التصدير غير موجود", backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'الاسم',
                      labelText: 'الاسم',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'يرجى اضافة الاسم';
                      }
                      name = text;
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  TextFormField(
                    controller: dateController,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'التاريخ',
                      labelText: 'التاريخ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'يرجى اضافة التاريخ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  TextFormField(
                    controller: placeController,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintText: 'المكان',
                      labelText: 'مكان الحفلة',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'يرجى اضافة المكان';
                      }
                      place = text;
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  TextFormField(
                    controller: mobileController,
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'الهاتف ',
                      labelText: 'رقم الهاتف',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'يرجى اضافة رقم الهاتف ';
                      }
                      mobile = text;
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  TextFormField(
                    controller: totalFeeController,
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'مبلغ الاجمالي',
                      labelText: 'مبلغ الاجمالي ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'يرجى اضافة مبلغ الكلي ';
                      }
                      totalFee = text;
                      return null;
                    },
                  ),
                  const SizedBox(height: 17),
                  TextFormField(
                    controller: feePaidController,
                    textDirection: TextDirection.rtl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'مبلغ المدفوعة',
                      labelText: 'المدفوع',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return 'يرجى اضافة مبلغ المدفوعة';
                      }
                      feePaid = text;
                      return null;
                    },
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        Student s = Student(
                          name: name,
                          date: dateController.text,
                          place: place,
                          mobile: mobile,
                          totalFee: int.parse(totalFee),
                          feePaid: int.parse(feePaid),
                        );

                        int result = await DatabaseHelper.instance.insertStudent(s);

                        if (result > 0) {
                          Fluttertoast.showToast(msg: "تم حفظ بنجاح", backgroundColor: Colors.green);
                          clearFields(); // Clear the fields after successful save
                        } else {
                          Fluttertoast.showToast(msg: "فشل في حفظ السجل", backgroundColor: Colors.red);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, // Use a sky color here
                    ),
                    child: const Text(
                      'حفظ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      exportData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                    ),
                    child: const Text(
                      'تصدير البيانات',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      importData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: const Text(
                      'استيراد البيانات',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
