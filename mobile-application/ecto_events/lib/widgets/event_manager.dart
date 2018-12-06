import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventManager extends StatelessWidget {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Manager'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                    decoration: new InputDecoration(
                        icon: const Icon(Icons.label),
                        hintText: 'Some cool event',
                        labelText: 'Event Name'
                    )
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.calendar_today),
                    hintText: 'Event 2018-08-24',
                    labelText: 'Event Date',
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Submit',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () => null,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}