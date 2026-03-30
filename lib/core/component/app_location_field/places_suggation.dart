import 'package:coffie/core/component/app_location_field/location_repository.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceAutocompleteWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(
    String placeId,
    String description, {
    bool isCurrentLocation,
    double? lat,
    double? lng,
  })
  onPlaceSelected;

  final bool showCurrentLocation;
  final String? currentLocationAddress;
  final double? currentLocationLat;
  final double? currentLocationLng;

  final Widget? prefixIcon;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final double? maxSuggestionsHeight;
  final int? maxSuggestions;
  final bool enabled;
  final FocusNode? focusNode;

  final Color? textColor;
  final Color? hintColor;
  final Color? borderColor;
  final Color? fieldColor;
  final double? borderWidth;
  final double? borderRadius;

  const PlaceAutocompleteWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onPlaceSelected,
    this.showCurrentLocation = false,
    this.currentLocationAddress,
    this.currentLocationLat,
    this.currentLocationLng,
    this.prefixIcon,
    this.decoration,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
    this.maxSuggestionsHeight = 200,
    this.maxSuggestions,
    this.enabled = true,
    this.focusNode,
    this.textColor,
    this.hintColor,
    this.borderColor,
    this.fieldColor,
    this.borderWidth,
    this.borderRadius,
  });

  @override
  State<PlaceAutocompleteWidget> createState() =>
      _PlaceAutocompleteWidgetState();
}

class _PlaceAutocompleteWidgetState extends State<PlaceAutocompleteWidget> {
  final LocationRepository _locationRepository = LocationRepository();

  late FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  List<dynamic> _predictions = [];
  bool _isLoading = false;
  bool _isDisposed = false;

  final GlobalKey _fieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay(); // focus chole gele hide
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _removeOverlay();
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  // ================= OVERLAY =================

  void _showOverlay() {
    if (_overlayEntry != null) return;
    if (_predictions.isEmpty) return; // ✅ empty hole show na

    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox =
        _fieldKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => CompositedTransformFollower(
        link: _layerLink,
        showWhenUnlinked: false,
        offset: Offset(0, size.height + 5),
        child: Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: size.width,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.maxSuggestionsHeight ?? 200,
              ),
              child: _isLoading ? _buildLoading() : _buildSuggestionsList(),
            ),
          ),
        ),
      ),
    );
  }

  // ================= API =================

  Future<void> _searchPlaces(String query) async {
    if (!mounted || _isDisposed) return;

    if (query.isEmpty) {
      _predictions = [];
      _removeOverlay(); // ✅ empty hole hide
      return;
    }

    setState(() => _isLoading = true);

    try {
      final predictions = await _locationRepository.placeAutoComplete(query);

      if (!mounted || _isDisposed) return;

      List<dynamic> finalPredictions = [];

      if (widget.showCurrentLocation && widget.currentLocationAddress != null) {
        finalPredictions.add({
          'place_id': 'current_location',
          'description': widget.currentLocationAddress!,
          'is_current_location': true,
        });
      }

      finalPredictions.addAll(predictions);

      if (widget.maxSuggestions != null &&
          finalPredictions.length > widget.maxSuggestions!) {
        finalPredictions = finalPredictions
            .take(widget.maxSuggestions!)
            .toList();
      }

      _predictions = finalPredictions;
      _isLoading = false;

      if (_predictions.isNotEmpty) {
        if (_overlayEntry == null) {
          _showOverlay(); // ✅ only now show
        } else {
          _overlayEntry?.markNeedsBuild();
        }
      } else {
        _removeOverlay();
      }
    } catch (_) {
      _isLoading = false;
      _removeOverlay();
    }
  }

  Future<void> _selectPlace(
    String placeId,
    String description,
    bool isCurrentLocation,
  ) async {
    if (_isDisposed) return;

    _removeOverlay();
    widget.controller.text = description;

    if (isCurrentLocation) {
      widget.onPlaceSelected(
        placeId,
        description,
        isCurrentLocation: true,
        lat: widget.currentLocationLat,
        lng: widget.currentLocationLng,
      );
      _focusNode.unfocus();
      return;
    }

    try {
      final placeDetails = await _locationRepository.getPlaceDetails(placeId);

      widget.onPlaceSelected(
        placeId,
        description,
        isCurrentLocation: false,
        lat: placeDetails?['lat'],
        lng: placeDetails?['lng'],
      );
    } catch (_) {
      widget.onPlaceSelected(placeId, description, isCurrentLocation: false);
    }

    _focusNode.unfocus();
  }

  // ================= UI =================

  Widget _buildSuggestionsList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: _predictions.length,
      separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.yellow),
      itemBuilder: (context, index) {
        final item = _predictions[index];
        final isCurrent = item['is_current_location'] == true;

        return InkWell(
          onTap: () =>
              _selectPlace(item['place_id'], item['description'], isCurrent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  isCurrent ? Icons.my_location : Icons.location_on,
                  size: 20,
                  color: AppColors.yellow,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: isCurrent
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(AppColors.yellow),
            ),
          ),
          const SizedBox(width: 10),
          Text("Searching...", style: TextStyle(color: AppColors.yellow)),
        ],
      ),
    );
  }

  // ================= MAIN =================

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        key: _fieldKey,
        controller: widget.controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        cursorColor: widget.textColor ?? AppColors.black,
        style:
            widget.textStyle ??
            TextStyle(
              color: widget.textColor ?? Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
        onChanged: _searchPlaces,
        decoration:
            widget.decoration ??
            InputDecoration(
              fillColor: widget.fieldColor ?? AppColors.backgrounColor,
              hintText: widget.hintText,
              hintStyle:
                  widget.hintStyle ??
                  TextStyle(color: widget.hintColor ?? AppColors.yellow),
              prefixIcon: widget.prefixIcon,
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.yellow,
                  width: widget.borderWidth ?? 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.yellow,
                  width: widget.borderWidth ?? 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.yellow,
                  width: widget.borderWidth ?? 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                borderSide: BorderSide(
                  color: widget.borderColor ?? AppColors.yellow,
                  width: widget.borderWidth ?? 1,
                ),
              ),
            ),
      ),
    );
  }
}
