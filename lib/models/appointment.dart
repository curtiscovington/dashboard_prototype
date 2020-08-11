class Appointment {
  String name;
  DateTime date;

  Appointment({this.name, this.date});

  String formatDate() =>
      "${date.month}/${date.day}/${date.year} ${date.hour}:${date.minute}";
}
