import 'package:flutter/material.dart';

class BellumDrawer extends StatelessWidget {
  const BellumDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
        backgroundColor: const Color(0xFF363740),
        child: Column(
          children: [
            DrawerHeader(
              child: ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  'B E L L U M',
                  style: theme.textTheme.headline5!.copyWith(
                    color: const Color(0xFFA4A6B3),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.pie_chart,
                color: Color(0xFFA4A6B3),
              ),
              title: Text(
                'O v e r v i e w',
                style: theme.textTheme.headline6!.copyWith(
                  color: const Color(0xFFA4A6B3),
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.airplane_ticket,
                color: Color(0xFFA4A6B3),
              ),
              title: Text(
                'T i c k e t s',
                style: theme.textTheme.headline6!.copyWith(
                  color: const Color(0xFFA4A6B3),
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.bubble_chart,
                color: Color(0xFFA4A6B3),
              ),
              title: Text(
                'I d e a s',
                style: theme.textTheme.headline6!.copyWith(
                  color: const Color(0xFFA4A6B3),
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Color(0xFFA4A6B3),
              ),
              title: Text(
                'C o n t a c t s',
                style: theme.textTheme.headline6!.copyWith(
                  color: const Color(0xFFA4A6B3),
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_alt_1,
                color: Color(0xFFA4A6B3),
              ),
              title: Text(
                'A g e n t s',
                style: theme.textTheme.headline6!.copyWith(
                  color: const Color(0xFFA4A6B3),
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.article,
                color: Color(0xFFA4A6B3),
              ),
              title: Text(
                'A r t i c l e s',
                style: theme.textTheme.headline6!.copyWith(
                  color: const Color(0xFFA4A6B3),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ));
  }
}
