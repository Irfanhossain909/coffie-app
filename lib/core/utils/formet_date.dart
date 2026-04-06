String formatDate(dynamic inputDate) {
  try {
    if (inputDate == null || inputDate.toString().isEmpty) {
      return "Invalid date";
    }

    DateTime date;

    // Handle different input types
    if (inputDate is DateTime) {
      date = inputDate;
    } else if (inputDate is String) {
      date = DateTime.parse(inputDate);
    } else if (inputDate is int) {
      date = DateTime.fromMillisecondsSinceEpoch(inputDate);
    } else {
      return "Invalid date";
    }

    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    // Time formatting (12-hour with AM/PM)
    int hour = date.hour;
    int minute = date.minute;

    String period = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    if (hour == 0) hour = 12;

    String formattedMinute = minute.toString().padLeft(2, '0');

    return "${months[date.month - 1]} ${date.day}, ${date.year} • $hour:$formattedMinute $period";
  } catch (e) {
    return "Invalid date";
  }
}
