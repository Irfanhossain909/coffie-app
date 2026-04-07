import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeMapPreview extends StatefulWidget {
  final List<List<double>> merchantList; // [lat, long]
  final bool isReload; // 🔥 trigger reload externally

  const HomeMapPreview({
    super.key,
    required this.merchantList,
    this.isReload = false,
  });

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

    // 🔥 Reload when data changes OR external reload triggered
    if (widget.merchantList != oldWidget.merchantList ||
        widget.isReload != oldWidget.isReload) {
      _initializeMap();
    }
  }

  Future<void> _initializeMap() async {
    setState(() => _isLoading = true);

    try {
      if (widget.merchantList.isEmpty) {
        _initialPosition = const CameraPosition(
          target: LatLng(23.8103, 90.4125),
          zoom: 12,
        );
      } else {
        final firstLoc = widget.merchantList.first;

        _initialPosition = CameraPosition(
          target: LatLng(firstLoc[0], firstLoc[1]),
          zoom: 12,
        );

        Set<Marker> tempMarkers = {};

        for (int i = 0; i < widget.merchantList.length; i++) {
          final loc = widget.merchantList[i];

          tempMarkers.add(
            Marker(
              markerId: MarkerId(i.toString()),
              position: LatLng(loc[0], loc[1]),
              infoWindow: InfoWindow(title: 'Merchant ${i + 1}'),
              icon: BitmapDescriptor.defaultMarker,
            ),
          );
        }

        _markers = tempMarkers;
      }
    } catch (e) {
      debugPrint("Map init error: $e");
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _zoomIn() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOut() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          /// ================= MAP / SHIMMER =================
          if (_isLoading || _initialPosition == null)
            Shimmer(
              duration: const Duration(seconds: 2),
              interval: const Duration(seconds: 1),
              color: Colors.white,
              colorOpacity: 0.3,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          else
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition!,
              markers: _markers,

              /// interactions
              zoomControlsEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: true,

              onMapCreated: (GoogleMapController controller) {
                if (!_controller.isCompleted) {
                  _controller.complete(controller);
                }
              },
            ),

          /// ================= ZOOM BUTTONS =================
          Positioned(
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Zoom In
                      InkWell(
                        onTap: _zoomIn,
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Divider(height: 1, color: Colors.white.withOpacity(0.4)),

                      /// Zoom Out
                      InkWell(
                        onTap: _zoomOut,
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_controller.isCompleted) {
      _controller.future.then((controller) => controller.dispose());
    }
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
//         _initialPosition = const CameraPosition(
//           target: LatLng(23.8103, 90.4125), // Dhaka fallback
//           zoom: 16,
//         );
//       } else {
//         final firstLoc = widget.merchantList.first;

//         _initialPosition = CameraPosition(
//           target: LatLng(firstLoc[0], firstLoc[1]),
//           zoom: 16,
//         );

//         Set<Marker> tempMarkers = {};

//         for (int i = 0; i < widget.merchantList.length; i++) {
//           final loc = widget.merchantList[i];

//           tempMarkers.add(
//             Marker(
//               markerId: MarkerId(i.toString()),
//               position: LatLng(loc[0], loc[1]),
//               infoWindow: InfoWindow(title: 'Merchant ${i + 1}'),
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                 BitmapDescriptor.hueRed,
//               ),
//             ),
//           );
//         }

//         _markers = tempMarkers;
//       }

//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     } catch (e) {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading || _initialPosition == null) {
//       return const Center(child: CircularProgressIndicator(strokeWidth: 2));
//     }

//     return SizedBox(
//       height: 250, // খুব important (parent scroll issue avoid)
//       width: double.infinity,
//       child: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _initialPosition!,
//         markers: _markers,

//         /// ✅ FULL INTERACTION ENABLED
//         liteModeEnabled: false,
//         scrollGesturesEnabled: true,
//         zoomGesturesEnabled: true,
//         tiltGesturesEnabled: true,
//         rotateGesturesEnabled: true,

//         /// optional controls
//         zoomControlsEnabled: false,
//         myLocationButtonEnabled: false,
//         compassEnabled: true,

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
