# web_convenient_view

This package is used to simplify reloading, or directly loading views when running in a web browser. This package is compatible with all flutter platforms. Works with hash, or path [url strategy](https://docs.flutter.dev/ui/navigation/url-strategies)

## How to

- Create a model to contain data that will be required in a view

  ```dart
  /// a sample data model, any data could be in here
  class DataRequiredModel {
    /// sample data
    final String someData;

    const DataRequiredModel({
      required this.someData,
    });
  }
  ```

- Create a view that requires data to load
  - see in the code below how the model created before is required
    - ```final DataRequiredModel model;```

  ```dart
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
  ```

- Create a view that can be loaded without any passed data
  - This will be the view routed back to in the event the ```DataRequiredView``` is reloaded in a web browser
  - in this example there is a button that navigates to the ```DataRequiredView``` when pressed, see how an argument is passed ```arguments: const DataRequiredModel``` ... This is the way ```DataRequiredView``` gets its data

  ```dart
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
  ```

- Setup the ```MaterialApp``` routes
  - see how named routes are used, and home is set

  ```dart
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
  ```
