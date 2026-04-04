import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeMapPreview extends StatefulWidget {
  final List<List<double>> merchantList; // [lat, long]

  const HomeMapPreview({super.key, required this.merchantList});

  @override
  State<HomeMapPreview> createState() => _HomeMapPreviewState();
}

class _HomeMapPreviewState extends State<HomeMapPreview> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> _markers = {};
  CameraPosition? _initialPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void didUpdateWidget(covariant HomeMapPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.merchantList != oldWidget.merchantList) {
      _initializeMap();
    }
  }

  Future<void> _initializeMap() async {
    try {
      if (widget.merchantList.isEmpty) {
        _initialPosition = const CameraPosition(
          target: LatLng(23.8103, 90.4125), // Dhaka fallback
          zoom: 16,
        );
      } else {
        final firstLoc = widget.merchantList.first;

        _initialPosition = CameraPosition(
          target: LatLng(firstLoc[0], firstLoc[1]),
          zoom: 16,
        );

        Set<Marker> tempMarkers = {};

        for (int i = 0; i < widget.merchantList.length; i++) {
          final loc = widget.merchantList[i];

          tempMarkers.add(
            Marker(
              markerId: MarkerId(i.toString()),
              position: LatLng(loc[0], loc[1]),
              infoWindow: InfoWindow(title: 'Merchant ${i + 1}'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          );
        }

        _markers = tempMarkers;
      }

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _initialPosition == null) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return SizedBox(
      height: 250, // খুব important (parent scroll issue avoid)
      width: double.infinity,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition!,
        markers: _markers,

        /// ✅ FULL INTERACTION ENABLED
        liteModeEnabled: false,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        rotateGesturesEnabled: true,

        /// optional controls
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        compassEnabled: true,

        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.future.then((controller) => controller.dispose());
    super.dispose();
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class HomeMapPreview extends StatefulWidget {
//   final List<List<double>> merchantList; // [lat, long]

//   const HomeMapPreview({super.key, required this.merchantList});

//   @override
//   State<HomeMapPreview> createState() => _HomeMapPreviewState();
// }

// class _HomeMapPreviewState extends State<HomeMapPreview> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   Set<Marker> _markers = {};
//   final Set<Circle> _circles = {};
//   CameraPosition? _initialPosition;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeMap();
//   }

//   @override
//   void didUpdateWidget(covariant HomeMapPreview oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.merchantList != oldWidget.merchantList) {
//       _initializeMap();
//     }
//   }

//   Future<void> _initializeMap() async {
//     try {
//       if (widget.merchantList.isEmpty) {
//         // Default position if list is empty
//         _initialPosition = const CameraPosition(
//           target: LatLng(37.42796133580664, -122.085749655962),
//           zoom: 12,
//         );
//       } else {
//         // Use first merchant location as initial camera position
//         final firstLoc = widget.merchantList[0];
//         _initialPosition = CameraPosition(
//           target: LatLng(firstLoc[0], firstLoc[1]),
//           zoom: 20,
//         );

//         // Create markers
//         Set<Marker> tempMarkers = {};
//         for (int i = 0; i < widget.merchantList.length; i++) {
//           final loc = widget.merchantList[i];
//           tempMarkers.add(
//             Marker(
//               markerId: MarkerId(i.toString()),
//               position: LatLng(loc[0], loc[1]),
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                 BitmapDescriptor.hueRed,
//               ),
//             ),
//           );
//         }
//         _markers = tempMarkers;

//         // Create a circle of 10 km radius around first location
//         _circles.add(
//           Circle(
//             circleId: const CircleId('circle_10km'),
//             center: LatLng(firstLoc[0], firstLoc[1]),
//             radius: 5000, // 10 km in meters
//             fillColor: Colors.blue.withValues(alpha: 0.2),
//             strokeColor: Colors.blue.withValues(alpha: 0.5),
//             strokeWidth: 2,
//           ),
//         );
//       }

//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading || _initialPosition == null) {
//       return const Center(child: CircularProgressIndicator(strokeWidth: 2));
//     }

//     return AbsorbPointer(
//       child: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _initialPosition!,
//         markers: _markers,
//         circles: _circles,
//         myLocationButtonEnabled: false,
//         myLocationEnabled: false,
//         zoomControlsEnabled: false,
//         mapToolbarEnabled: false,
//         scrollGesturesEnabled: false,
//         zoomGesturesEnabled: false,
//         tiltGesturesEnabled: false,
//         rotateGesturesEnabled: false,
//         compassEnabled: false,
//         liteModeEnabled: true,
//         onMapCreated: (GoogleMapController controller) {
//           if (!_controller.isCompleted) {
//             _controller.complete(controller);
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.future.then((controller) => controller.dispose());
//     super.dispose();
//   }
// }
