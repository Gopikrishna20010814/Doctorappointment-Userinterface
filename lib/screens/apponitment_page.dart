import 'package:docterappointment/utils/config.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, complete, cancel }

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> shedules = [
    {
      "doctor_name": "Richard",
      "doctor_profile": "assets/doctor_2.jpg",
      "category": "Dental",
      "Status": FilterStatus.upcoming,
    },
    {
      "doctor_name": "Suresh",
      "doctor_profile": "assets/doctor_3.jpg",
      "category": "Cardiology",
      "Status": FilterStatus.complete,
    },
    {
      "doctor_name": "Shree",
      "doctor_profile": "assets/doctor_4.jpg",
      "category": "Resperation",
      "Status": FilterStatus.complete,
    },
    {
      "doctor_name": "Raj",
      "doctor_profile": "assets/doctor_1.jpg",
      "category": "Dental",
      "Status": FilterStatus.cancel,
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = shedules.where((var schedule) {
      //switch (schedule['Status']) {
      //case 'Upcoming':
      //schedule['status'] = FilterStatus.upcoming;
      //break;
      //case 'Complete':
      //schedule['status'] = FilterStatus.complete;
      //break;
      //case 'Cancel':
      //schedule['status'] = FilterStatus.cancel;
      //break;
      //}
      return schedule['status'] == status;
    }).toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Appointment Schedule',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (filterStatus == FilterStatus.upcoming) {
                                status = FilterStatus.upcoming;
                                _alignment = Alignment.centerLeft;
                              } else if (filterStatus ==
                                  FilterStatus.complete) {
                                status = FilterStatus.complete;
                                _alignment = Alignment.center;
                              } else if (filterStatus == FilterStatus.cancel) {
                                status = FilterStatus.cancel;
                                _alignment = Alignment.centerRight;
                              }
                            });
                          },
                          child: Center(
                            child: Text(filterStatus.name),
                          ),
                        ))
                    ],
                  ),
                ),
                AnimatedAlign(
                    alignment: _alignment,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Config.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(status.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ),
                    )
              ],
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
              itemCount: filteredSchedules.length,
              itemBuilder: ((context, index) {
                var shedule=filteredSchedules[index];
                bool isLastElement=filteredSchedules.length + 1 == index;
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: !isLastElement 
                  ?const EdgeInsets.only(bottom: 20)
                  :EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: 
                            AssetImage(shedule['docter_profile']),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shedule['docter_name'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                               shedule['category'],
                               style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                               ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                  ),
                );
              }
              )
              )
              )
          ],
        ),
      ),
    );
  }
}