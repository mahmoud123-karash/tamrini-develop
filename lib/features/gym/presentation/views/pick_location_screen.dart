import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:tamrini/core/services/location.dart';
import 'package:tamrini/features/gym/presentation/views/widgets/my_location_button_map_widget.dart';
import 'widgets/location_search_dialog_widget.dart';
import 'widgets/map_navigate_button_widget.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({Key? key}) : super(key: key);

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  late CameraPosition _cameraPosition;
  LatLng? value;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    value = const LatLng(33.3118944, 44.4959932);
    _cameraPosition = const CameraPosition(
      target: LatLng(33.3118944, 44.4959932),
      zoom: 14.4746,
    );
  }

  late GoogleMapController _mapController;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            trafficEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: onMapCreated,
            initialCameraPosition: _cameraPosition,
            onCameraMove: (CameraPosition newPosition) {
              value = newPosition.target;
            },
          ),
          LocationSearchDialog(
            controller: controller,
            onSuggestionSelected: (Prediction suggestion) {
              setLocation(suggestion, _mapController);
              controller.text = suggestion.description ?? '';
              setState(() {});
            },
          ),
          Positioned(
            bottom: height / 2,
            right: (MediaQuery.of(context).size.width - 30) / 2,
            child: const Icon(
              Icons.person_pin_circle,
              size: 30,
              color: Colors.black,
            ),
          ),
          MyLocationButtonMapWidget(
            onPressed: () async {
              var position = await determinePosition();
              _mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 20,
                  ),
                ),
              );
            },
          ),
          const MapNavigateButtonWidget(),
        ],
      ),
    );
  }
}
