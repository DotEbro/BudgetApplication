import 'package:budget_app/colours.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../drawer.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({ Key? key }) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool lockInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(color: Colors.white),),
        backgroundColor: primarycolor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      //drawer: Drawerr(),
       body: SettingsList(
        contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.0, horizontal: MediaQuery.of(context).size.width*0.02),
       sections: [
        SettingsSection(
            title: Text('Select Language', style: TextStyle(color: Colors.black),),
            tiles: [
              SettingsTile.switchTile(
                title: Text('English', style: TextStyle(fontSize: 15),),
                leading: Icon(Icons.language, size: 19,),
               initialValue: lockInBackground,
                onToggle: (bool value) {
                  setState(() {
                    lockInBackground = value;
                  });
                },
              ),
              SettingsTile.switchTile(
                title: Text('Arabic', style: TextStyle(fontSize: 15),),
                leading: Icon(Icons.language, size: 19,),
               initialValue: false,
                onToggle: (bool value) {
                  
                },
              ),])
       ],
       )
    );
  }
}