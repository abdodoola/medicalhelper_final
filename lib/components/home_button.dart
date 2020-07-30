import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  HomeButton({@required this.onPressed, this.title,this.icon});

  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 10.0,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 350.0,
          height: 60.0,
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.teal,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.teal.shade900,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
