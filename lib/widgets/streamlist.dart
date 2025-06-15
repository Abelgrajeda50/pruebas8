import 'dart:async';
import 'package:flutter/material.dart';
import '../clases/mensaje.dart';

class StreamListViewPage extends StatefulWidget {
  @override
  _StreamListViewPageState createState() => _StreamListViewPageState();
}

class _StreamListViewPageState extends State<StreamListViewPage> {
  final StreamController<Mensaje> _streamController = StreamController<Mensaje>();
  final List<Mensaje> _items = [];
  Timer? _timer;
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      _counter++;
      final nuevoMensaje = Mensaje(_counter, "Mensaje número $_counter");
      _streamController.sink.add(nuevoMensaje);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("StreamBuilder + ListView")),
      body: StreamBuilder<Mensaje>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error en el stream"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Esperando datos"));
          }

          if (snapshot.hasData) {
            _items.add(snapshot.data!);
          }

          return ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final mensaje = _items[index];
              return ListTile(
                leading: CircleAvatar(child: Text("${mensaje.id}")),
                title: Text(mensaje.texto),
              );
            },
          );
        },
      ),
    );
  }
}
