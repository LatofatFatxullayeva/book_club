import 'package:book_club/screens/creategroup/create_group.dart';
import 'package:book_club/screens/joingroup/join_group.dart';
import 'package:flutter/material.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    void goToJoin(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JoinGroup(),
          ));
    }

    void goToCreate(BuildContext context) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateGroup(),
          ));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.all(80),
            child: Image.asset(
              "assets/logo.png",
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Welcome to Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Since you are not in a book club, you can select either to join a club or create a club",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => goToCreate(context),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Theme.of(context).canvasColor),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: Theme.of(context).secondaryHeaderColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Create",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => goToJoin(context),
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.primary)),
                  child: const Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
