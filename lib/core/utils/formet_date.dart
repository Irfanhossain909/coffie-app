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

    // Format: May 15, 2026
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];

    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  } catch (e) {
    return "Invalid date";
  }
}