import 'package:flutter/material.dart';
import 'package:login/main_dashboard/main_dashboard.dart';

class BookingPage extends StatefulWidget {
  BookingPage({
    super.key,
    required this.locName,
  });

  String locName;

  @override
  State<BookingPage> createState() {
    return _BookingPageState();
  }
}

class _BookingPageState extends State<BookingPage> {
  String name = "";
  String email = "";
  String phone = "";
  String date = ""; // Datetime can be used

  @override
  Widget build(BuildContext context) {
    String locationName = widget.locName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Book a trip to $locationName "),
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                if (value != '') {
                  name = value;
                }
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                if (value != '') {
                  email = value;
                }
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              onChanged: (value) {
                if (value != '') {
                  phone = value;
                }
              },
            ),
            // Optional Date Picker widget
            // You can implement this using showDatePicker function
            // TextField(
            //   decoration: InputDecoration(labelText: 'Date'),
            //   onTap: () async {
            //     final selectedDate = await showDatePicker(
            //       context: context,
            //       initialDate: DateTime.now(),
            //       firstDate: DateTime(2024),
            //       lastDate: DateTime(2025),
            //     );
            //     if (selectedDate != null) {
            //       setState(() => date = selectedDate.toString());
            //     }
            //   },
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission (can display a confirmation dialog)
                if (name == '' || email == '' || phone == '') {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: const Text('Field(s) must not be blank'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK')),
                            ],
                          ));
                } else {
                  
                  //print("---------------------------------------");
                  //print("$name  $phone $email");

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfirmationPage()),
                      ModalRoute.withName(
                          "login/main_dashboard/main_dashboard.dart'"));
                }
              },
              child: Text('Submit Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: null //Text('Confirmation'),
      //    ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Thank you for using our booking services!',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              const Text(
                'You will soon be contacted by our staff for your trip confirmation.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
