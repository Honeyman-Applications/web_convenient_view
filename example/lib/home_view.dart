/*
  Bradley Honeyman
  Oct 10, 2023

*/

import 'package:example/data_required_view.dart';
import 'package:flutter/material.dart';
import 'data_required_model.dart';

/// A home view, no data required to load
class HomeView extends StatelessWidget {
  /// added as a convenience, could be entered another way
  static const routeName = "/home_view";

  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*
              On pressed navigate to DataRequiredView, and pass a DataRequiredModel
            */
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  DataRequiredView.routeName,
                  arguments: const DataRequiredModel(
                    someData: "Data from home_view. Refresh this page in the web browser Ctrl+r",
                  ),
                );
              },
              child: const Text(
                "Navigate to data_required_view",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
