/*
  Bradley Honeyman
  Oct 10, 2023

*/

import 'package:flutter/material.dart';
import 'data_required_model.dart';

/// A view that requires data to load correctly
class DataRequiredView extends StatelessWidget {
  /// added as a convenience, could be entered another way
  static const String routeName = "/data_required_view";

  /// data required to load the model (sample data)
  final DataRequiredModel model;

  const DataRequiredView({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.someData,
            ),
          ],
        ),
      ),
    );
  }
}
