import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preferences/preferences.dart';
import 'package:quraana_oromiffa/global/theme/app_themes.dart';
import 'package:quraana_oromiffa/global/theme/bloc/theme_bloc.dart';
import 'package:quraana_oromiffa/global/theme/bloc/theme_event.dart';

class PreferencePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PreferencePageStates();
  }
}

class PreferencePageStates extends State<PreferencePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: PreferencePage([
        PreferenceTitle('General'),
        DropdownPreference(
          'Theme',
          'themes',
          defaultVal: 'Light',
          values: ['Light', 'Dark'],
          onChange: () {},
        ),
        PreferenceTitle('Personalization'),
        RadioPreference(
          'Magariisa',
          'magariisa',
          'ui_theme',
          isDefault: true,
          onSelect: () {
            BlocProvider.of<ThemeBloc>(context).dispatch(
              ThemeChanged(theme: AppTheme.GreenLight),
            );
          },
        ),
        RadioPreference(
          'Cuuquliisa',
          'keelloo',
          'ui_theme',
          onSelect: () {
            BlocProvider.of<ThemeBloc>(context).dispatch(
              ThemeChanged(theme: AppTheme.BlueLight),
            );
          },
        ),
        RadioPreference(
          'Diimaa',
          'diimaa',
          'ui_theme',
          onSelect: () {
            BlocProvider.of<ThemeBloc>(context).dispatch(
              ThemeChanged(theme: AppTheme.RedLight),
            );
          },
        ),
        RadioPreference(
          'Magaala',
          'magaala',
          'ui_theme',
          onSelect: () {
            BlocProvider.of<ThemeBloc>(context).dispatch(
              ThemeChanged(theme: AppTheme.BrownLight),
            );
          },
        ),
        RadioPreference(
          'Grey',
          'grey',
          'ui_theme',
          onSelect: () {
            BlocProvider.of<ThemeBloc>(context).dispatch(
              ThemeChanged(theme: AppTheme.GreyDark),
            );
          },
        ),
      ]),
    );
  }
}
