import 'dart:math';

import 'package:dashboard_prototype/models/appointment.dart';
import 'package:dashboard_prototype/widgets/dashboard_tile.dart';
import 'package:flutter/material.dart';

enum AppointmentType { Generic, Followup, Call }

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int leads;
  int texts;
  int inCalls;
  int outCalls;

  AppointmentType currentTab;
  List<Appointment> appointments = [];
  List<Appointment> followups = [];
  List<Appointment> calls = [];

  @override
  void initState() {
    super.initState();
    this.leads = 0;
    this.texts = 0;
    this.inCalls = 0;
    this.outCalls = 0;

    this.currentTab = AppointmentType.Generic;
    this.appointments = List.generate(
        10,
        (index) => Appointment(
              name: "John Smith",
              date: DateTime.now(),
            ));

    this.followups = List.generate(
        2,
        (index) => Appointment(
              name: "Jane Doe",
              date: DateTime.now(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: RefreshIndicator(
          onRefresh: () async => {
            setState(() {
              this.leads = Random.secure().nextInt(10);
              this.texts = Random.secure().nextInt(10);
              this.outCalls = Random.secure().nextInt(10);
              this.inCalls = Random.secure().nextInt(10);
            })
          },
          child: ListView(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  DashboardTile(
                      number: leads,
                      color: Colors.red,
                      title: "Leads",
                      icon: Icons.people),
                  DashboardTile(
                      number: texts,
                      color: Colors.blue,
                      title: "Texts",
                      icon: Icons.sms),
                  DashboardTile(
                      number: outCalls,
                      color: Colors.green,
                      title: "Outbound Calls",
                      icon: Icons.phone),
                  DashboardTile(
                      number: inCalls,
                      color: Colors.purple,
                      title: "Inbound Calls",
                      icon: Icons.phone_callback),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Card(
                          color: Colors.white,
                          child: Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        buildAppointmentsTitle(),
                                        Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.calendar_today,
                                                    color: currentTab ==
                                                            AppointmentType
                                                                .Generic
                                                        ? Theme.of(context)
                                                            .accentColor
                                                        : Colors.black),
                                                onPressed: () {
                                                  setState(() {
                                                    currentTab =
                                                        AppointmentType.Generic;
                                                  });
                                                }),
                                            IconButton(
                                                icon: Icon(
                                                    Icons.follow_the_signs,
                                                    color: currentTab ==
                                                            AppointmentType
                                                                .Followup
                                                        ? Theme.of(context)
                                                            .accentColor
                                                        : Colors.black),
                                                onPressed: () {
                                                  setState(() {
                                                    currentTab = AppointmentType
                                                        .Followup;
                                                  });
                                                }),
                                            IconButton(
                                                icon: Icon(Icons.phone,
                                                    color: currentTab ==
                                                            AppointmentType.Call
                                                        ? Theme.of(context)
                                                            .accentColor
                                                        : Colors.black),
                                                onPressed: () {
                                                  setState(() {
                                                    currentTab =
                                                        AppointmentType.Call;
                                                  });
                                                })
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  buildTab()
                                ],
                              ))),
                      Positioned(
                          left: 10,
                          top: -10,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ))),
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget buildTab() {
    switch (currentTab) {
      case AppointmentType.Generic:
        return appointments.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appointments.length,
                itemBuilder: (context, index) => ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(appointments[index].name),
                      Text(appointments[index].formatDate())
                    ],
                  ),
                ),
              )
            : Text("No appointments today.");
      case AppointmentType.Followup:
        return followups.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: followups.length,
                itemBuilder: (context, index) => ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(followups[index].name),
                      Text(followups[index].formatDate())
                    ],
                  ),
                ),
              )
            : Text("No followups today.");
      case AppointmentType.Call:
        return calls.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: calls.length,
                itemBuilder: (context, index) => ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(calls[index].name),
                      Text(calls[index].formatDate())
                    ],
                  ),
                ),
              )
            : Text("No calls today.");
    }
  }

  Text buildAppointmentsTitle() {
    switch (currentTab) {
      case AppointmentType.Generic:
        return Text("Appointments");
      case AppointmentType.Followup:
        return Text("Followups");
      case AppointmentType.Call:
        return Text("Calls");
    }
  }
}
