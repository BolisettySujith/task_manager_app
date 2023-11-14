import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarClient {
  static final _scopes = [CalendarApi.calendarScope];

  insert(title, startTime, endTime) {
    var clientID = ClientId("YOUR_API_KEY", "");
    clientViaUserConsent(clientID, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL________$value"));

      String calendarId = "primary";
      Event event = Event(); // Create object of event

      event.summary = title;

      EventDateTime start = EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+05:00";
      event.start = start;

      EventDateTime end = EventDateTime();
      end.timeZone = "GMT+05:00";
      end.dateTime = endTime;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            print('Event added in google calendar');
          } else {
            print("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        print('Error creating event $e');
      }
    });
  }

  Future<void> prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}