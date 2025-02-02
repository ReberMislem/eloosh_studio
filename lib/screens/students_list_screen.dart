import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:students_ms/db/database_helper.dart';
import 'package:students_ms/models/student.dart';
import 'package:students_ms/screens/update_student_screen.dart';

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({Key? key}) : super(key: key);

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  List<Student> allStudents = [];
  List<Student> filteredStudents = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    List<Student> students = await DatabaseHelper.instance.getAllStudents();
    setState(() {
      allStudents = students;
      sortStudents();
    });
  }

  void sortStudents() {
    allStudents.sort((a, b) => b.date.compareTo(a.date)); // Sort by date descending
    filteredStudents = List.from(allStudents);
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Student> dummyListData = [];
      for (var item in allStudents) {
        if (item.date.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredStudents = dummyListData;
      });
    } else {
      setState(() {
        filteredStudents = List.from(allStudents);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: searchController,
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
                      searchController.text = formattedDate;
                      filterSearchResults(formattedDate);
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'البحث عن طريق التاريخ',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: filteredStudents.isEmpty
                  ? const Center(child: Text('لا يوجد سجلات'))
                  : ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  Student s = filteredStudents[index];
                  return Card(
                    margin: const EdgeInsets.all(15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              s.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'التاريخ: ${s.date}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'المكان: ${s.place}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'الهاتف: ${s.mobile}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'المبلغ الكلي: ${s.totalFee}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'المبلغ المدفوع: ${s.feePaid}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  String result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpdateStudentScreen(student: s);
                                      },
                                    ),
                                  );

                                  if (result == 'done') {
                                    setState(() {
                                      fetchStudents();
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                ),
                                child: const Text(
                                  'التعديل',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('التأكيد!!!'),
                                        content: const Text('هل أنت متأكد من الحذف؟'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('لا'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();

                                              // delete student
                                              int result = await DatabaseHelper.instance.deleteStudent(s.id!);

                                              if (result > 0) {
                                                Fluttertoast.showToast(msg: 'تم الحذف');
                                                setState(() {
                                                  fetchStudents();
                                                });
                                              }
                                            },
                                            child: const Text('نعم'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'الحذف',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
