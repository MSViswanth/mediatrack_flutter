import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediatrack_flutter/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    String userName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(12),
          children: <Widget>[
            //Username Selector.
            ListTile(
              title: Text(
                settingsProvider.getUserName(),
                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 20)),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: settingsProvider.themeData.brightness ==
                              Brightness.dark
                          ? Color(0xff161616)
                          : Color(
                              0xff757575), //Behind bottomsheet color. (Rounded Corners).
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .scaffoldBackgroundColor, //BottomSheet background color.
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              autofocus: true,
                              onChanged: (value) => userName = value,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                labelText: 'User name',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, style: BorderStyle.solid),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              child: FlatButton(
                                color: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'SAVE',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  settingsProvider.setUserName(userName);
                                  Navigator.pop(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }, //Username bottomsheet.
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            ListTile(
              title: Text(
                'Theme',
                style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 20)),
              ),
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: settingsProvider.themeData.brightness ==
                            Brightness.dark
                        ? Color(0xff161616)
                        : Color(
                            0xff757575), //Behind bottomsheet color. (Rounded Corners).
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor, //BottomSheet background color.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: AppTheme.values.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Get theme enum for the current item index
                          final theme = AppTheme.values[index];
                          return Card(
                            color: appThemeData[theme].primaryColor,
                            child: ListTile(
                              onTap: () {
                                // This will trigger notifyListeners and rebuild UI
                                // because of ChangeNotifierProvider in ThemeApp
                                settingsProvider.setTheme(theme);
                              },
                              title: Text(
                                enumName(theme),
                                style: appThemeData[theme].textTheme.bodyText2,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }, //Theme bottomsheet.
              ),
            ),
          ],
        ),
      ),
    );
  }
}
