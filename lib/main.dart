import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _kotaTujuanController = TextEditingController();
  TextEditingController _jarakController = TextEditingController();

  String _selectedBBM = 'Pertalite';
  String _selectedKendaraan = 'Avanza';

  Map<String, double> bbmPrices = {
    'Pertalite': 8000.0,
    'Pertamax': 9000.0,
    'Solar': 7500.0,
  };

  Map<String, double> bbmRatios = {
    'Avanza': 12.0,
    'Xenia': 11.5,
    'Sigra': 13.0,
    'Brio': 14.0,
  };

  double _result = 0.0;

  void _calculateBBM() {
    double jarak = double.parse(_jarakController.text);
    double hargaBBM = bbmPrices[_selectedBBM] ?? 0.0;
    double konsumsiBBM = bbmRatios[_selectedKendaraan] ?? 0.0;

    double bbmNeeded = jarak / konsumsiBBM;
    double totalBiaya = bbmNeeded * hargaBBM;

    setState(() {
      _result = totalBiaya;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detail Perjalanan'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Perjalanan menuju: ${_kotaTujuanController.text}'),
              Text('Jarak: ${jarak.toString()} km'),
              Text('Menggunakan: $_selectedKendaraan'),
              SizedBox(height: 16.0),
              Text('Memerlukan BBM:'),
              Text(
                  '${bbmNeeded.toStringAsFixed(2)} lt @${hargaBBM.toString()}'),
              SizedBox(height: 16.0),
              Text('Total Biaya:'),
              Text('Rp ${totalBiaya.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penghitung Biaya BBM'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _kotaTujuanController,
              decoration: InputDecoration(labelText: 'Kota Tujuan'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _jarakController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jarak (km)'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedBBM,
              items: bbmPrices.keys.map((String bbm) {
                return DropdownMenuItem<String>(
                  value: bbm,
                  child: Text(bbm),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedBBM = value ?? 'Pertalite';
                });
              },
              decoration: InputDecoration(labelText: 'Pilihan BBM'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedKendaraan,
              items: bbmRatios.keys.map((String kendaraan) {
                return DropdownMenuItem<String>(
                  value: kendaraan,
                  child: Text(kendaraan),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedKendaraan = value ?? 'Avanza';
                });
              },
              decoration: InputDecoration(labelText: 'Pilihan Kendaraan'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _calculateBBM();
              },
              child: Text('Hitung BBM'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Biaya BBM: Rp ${_result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
