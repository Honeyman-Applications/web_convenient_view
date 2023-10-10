/*
  Bradley Honeyman
  Oct 10, 2023

*/
library web_convenient_view;

import 'package:flutter/material.dart';

/// For simplifying having a view be reloaded in a web browser when data needs to be passed
class WebConvenientView<T> extends StatefulWidget {
  /// data to be passed to the widget returned in onLoaded
  final T? model;

  /// named route to go to in the event that the page has been reloaded in the web browser
  final String backRoute;

  /// arguments to pass to the backRoute when navigating to it
  final Object? backRouteArguments;

  /// The function that runs once loaded if the backRoute isn't navigated to
  final Widget Function(T model) onLoaded;

  /// what is shown just before the back route is navigated to.
  final Widget briefErrorDisplay;

  const WebConvenientView({
    super.key,
    this.model,
    required this.onLoaded,
    required this.backRoute,
    this.backRouteArguments,
    this.briefErrorDisplay = const Scaffold(),
  });

  @override
  State<StatefulWidget> createState() => WebConvenientViewState<T>();
}

/// State of WebConvenientView, used to perform checks, and display
class WebConvenientViewState<T> extends State<WebConvenientView<T>> {
  /// model value to be referenced, is set in didChangeDependencies
  T? _model;

  // check if model is passed by argument
  // if passed by constructor
  // otherwise navigate to the back route
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      // argument with model passed
      _model = ModalRoute.of(context)!.settings.arguments as T;
    } else if (widget.model != null) {
      // model passed in the constructor
      _model = widget.model;
    } else {
      // no model, therefore it is a reload, go to the back route
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
          context,
          widget.backRoute,
          arguments: widget.backRouteArguments,
        );
      });
    }
    super.didChangeDependencies();
  }

  // if doesn't have a model briefErrorDisplay is shown until
  // back route is navigated to
  @override
  Widget build(BuildContext context) {
    print("run");
    return _model != null
        ? widget.onLoaded(
            _model as T,
          )
        : widget.briefErrorDisplay;
  }
}
