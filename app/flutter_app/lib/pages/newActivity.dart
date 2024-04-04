import 'package:flutter/material.dart';


class newActivityPage extends StatefulWidget {
  const newActivityPage({super.key, required this.title});

  final String title;

  @override
  State<newActivityPage> createState() => _newActivityPageState();
}

class _newActivityPageState extends State<newActivityPage> {


  @override
  Widget build(BuildContext context) {


    final _formKeyActivity = GlobalKey<FormState>();
    late String _activityName;
    late String _activityDescription;
    late DateTime _activityDeadline = DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _activityDeadline,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _activityDeadline) {
      setState(() {
        _activityDeadline = pickedDate;
      });
    }
  }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: 600,
          height: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),

        child:
            Form(
              key: _formKeyActivity,
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
                    onSaved: (value) => _activityName = value!,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Activity Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the activity description';
                      }
                      return null;
                    },
                    onSaved: (value) => _activityDescription = value!,
                  ),
                  
                  

                  Row(
                    children: [
                      const Text('Activity Deadline:'),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          '${_activityDeadline.day}/${_activityDeadline.month}/${_activityDeadline.year}',
                        ),
                      ),
                    ],
                  ),





                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKeyActivity.currentState!.validate()) {
                        _formKeyActivity.currentState!.save();
                        // Here you can add the new activity to your list or perform other actions
                        // For now, let's just print the data
                        print('Activity Name: $_activityName');
                        print('Activity Description: $_activityDescription');
                        print('Activity Deadline: $_activityDeadline');
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
          Navigator.pop(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
