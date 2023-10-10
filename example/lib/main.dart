/*
  Bradley Honeyman
  Oct 10, 2023

*/

import 'package:example/data_required_view.dart';
import 'package:example/home_view.dart';
import 'package:flutter/material.dart';
import 'package:web_convenient_view/web_convenient_view.dart';
import 'data_required_model.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        // the route that doesn't need any data to load, see it is the home route
        HomeView.routeName: (_) => const HomeView(),
        /*
          Make use of WebConvenientView for when the page is reloaded in the browser, or
          when the page is loaded directly in the browser.
          Works with hash, or path url strategy.
          See how the generic data is DataRequiredModel, this is the type of data
          to be passed to DataRequiredView
        */

        // set route name, and return a WebConvenientView with a generic data of DataRequiredModel
        DataRequiredView.routeName: (_) => WebConvenientView<DataRequiredModel>(
              // set a backRoute, this is the route to be navigated to if DataRequiredView is reloaded or
              // loaded directly in a web browser. Shouldn't require data to load.
              backRoute: HomeView.routeName,

              // where DataRequiredView is loaded, and receives its data model.
              // This will not run if reloaded, or directly loaded in the web browser
              onLoaded: (model) => DataRequiredView(
                model: model,
              ),
            ),
      },

      // a view that doesn't require any data to load
      home: const HomeView(),
    ),
  );
}
