import 'package:flutter/material.dart';
import 'package:flutter_app/layout/index.dart';


class newActivityPage extends StatefulWidget {
  const newActivityPage({super.key, required this.title});

  final String title;

  @override
  State<newActivityPage> createState() => _newActivityPageState();
}


class _newActivityPageState extends State<newActivityPage> {

  @override
  Widget build(BuildContext context) {


    final formKeyActivity = GlobalKey<FormState>();
    late String activityName;
    late String activityDescription;
    late DateTime activityDeadline = DateTime.now();

    Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: activityDeadline,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != activityDeadline) {
      setState(() {
        activityDeadline = pickedDate;
      });
    }
  }


  return CommonLayout(
    pageTitle: widget.title,
    context: context,
    body: Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: 600,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child:
            Form(
              key: formKeyActivity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Activity Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the activity name';
                      }
                      return null;
                    },
                    onSaved: (value) => activityName = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Activity Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the activity description';
                      }
                      return null;
                    },
                    onSaved: (value) => activityDescription = value!,
                  ),
                  
                  Row(
                    children: [
                      const Text('Activity Deadline:'),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () => selectDate(context),
                        child: Text(
                          '${activityDeadline.day}/${activityDeadline.month}/${activityDeadline.year}',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKeyActivity.currentState!.validate()) {
                        formKeyActivity.currentState!.save();
                        // Here you can add the new activity to your list or perform other actions
                        // For now, let's just print the data
                        print('Activity Name: $activityName');
                        print('Activity Description: $activityDescription');
                        print('Activity Deadline: $activityDeadline');
                      }
                    },
                    child: const Text('Submit Activity'),
                  ),
                ],
              ),
            ),
          ),
        ),
        

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/users");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
      )
    );
  }
}
