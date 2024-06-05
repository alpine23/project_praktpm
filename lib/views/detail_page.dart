import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animate_do/animate_do.dart';
import '../services/apiDataSource_service.dart';
import '../models/detailEvent.dart';

class DetailPage extends StatefulWidget {
  final String slug, nama;
  const DetailPage({Key? key, required this.slug, required this.nama})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedTimeZone = 'WIB';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          widget.nama,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedTimeZone,
              onChanged: (String? newValue) {
                setState(() {
                  selectedTimeZone = newValue!;
                });
              },
              items: <String>['WIB', 'WITA', 'WIT', 'London']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(child: _buildDetailUser(widget.slug)),
        ],
      ),
    );
  }

  Widget _buildDetailUser(String slugDiterima) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailEvents(slugDiterima),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildError();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }
          if (snapshot.hasData) {
            Welcome welcome = Welcome.fromJson(snapshot.data);
            return _buildSuccess(welcome.data!);
          }
          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Text("Error loading data"),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  String convertTime(String time, String fromTimeZone, String toTimeZone) {
    var format = DateFormat("HH:mm:ss");
    var dateTime = format.parse(time, true).toUtc();
    dateTime = dateTime.add(Duration(
        hours: _timeZoneOffset(toTimeZone) - _timeZoneOffset(fromTimeZone)));
    return DateFormat("HH:mm:ss").format(dateTime);
  }

  int _timeZoneOffset(String timeZone) {
    switch (timeZone) {
      case 'WIB':
        return 7;
      case 'WITA':
        return 8;
      case 'WIT':
        return 9;
      case 'London':
        return 1; // During standard time (not considering daylight saving time)
      default:
        return 0;
    }
  }

  Widget _buildSuccess(Data data) {
    String startTime = data.waktuMulai ?? '15:00:00';
    String endTime = data.waktuSelesai ?? '15:00:00';

    String startConverted = convertTime(startTime, 'WIB', selectedTimeZone);
    String endConverted = convertTime(endTime, 'WIB', selectedTimeZone);

    return FadeInUp(
      duration: Duration(milliseconds: 500),
      child: ListView(
        children: [
          if (data.filename != null && data.filename!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://api.yesplis.com/images/banner/${data.filename}',
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 16.0),
          Text(
            data.nama ?? 'No Name',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.blue),
              title: Text(
                'Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                DateFormat('dd-MM-yyyy')
                    .format(data.tanggalMulai ?? DateTime.now()),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.access_time, color: Colors.green),
              title: Text(
                'Start Time ($selectedTimeZone):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(startConverted),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.access_time, color: Colors.red),
              title: Text(
                'End Time ($selectedTimeZone):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(endConverted),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.location_on, color: Colors.orange),
              title: Text(
                'Location:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data.namaTempat ?? 'Unknown'),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.map, color: Colors.purple),
              title: Text(
                'Address:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data.alamat ?? 'Unknown'),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data.deskripsi ?? 'Unknown'),
            ),
          )
        ],
      ),
    );
  }
}
