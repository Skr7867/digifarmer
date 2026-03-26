import 'dart:developer';
import 'dart:io';

import 'package:digifarmer/main.dart';
import 'package:digifarmer/res/customeWidgets/custom_app_bar.dart';
import 'package:digifarmer/res/customeWidgets/custom_textfield.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../blocs/LANDOWNERPANEL/landLocation/land_location_bloc.dart';
import '../../../config/routes/routes_name.dart';
import '../../../repository/LANDOWNERPANEL/landLocation/land_location_repository.dart';
import '../../../res/color/app_colors.dart';

class LocationScreen extends StatefulWidget {
  final String tempId;
  const LocationScreen({super.key, required this.tempId});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LandLocationBloc _landLocationBloc;

  File? imageFile;
  bool isLoading = false;
  bool isGettingLocation = false;

  // Controllers for manual entry
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _villageController = TextEditingController();
  final _tehsilController = TextEditingController();
  final _districtController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    log("TEMP ID RECEIVED => ${widget.tempId}");
    _landLocationBloc = LandLocationBloc(getIt<LandLocationRepository>());
    _landLocationBloc.add(SetTempId(widget.tempId));
  }

  @override
  void dispose() {
    _landLocationBloc.close();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    _villageController.dispose();
    _tehsilController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  Future<void> openCamera() async {
    try {
      setState(() {
        isLoading = true;
      });

      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1920,
      );

      if (photo == null) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      // Save image to app directory for permanent storage
      final directory = await getApplicationDocumentsDirectory();
      path.basename(photo.path);
      final savedImage = File(photo.path);
      final savedPath = path.join(
        directory.path,
        'location_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      final savedFile = await savedImage.copy(savedPath);

      setState(() {
        imageFile = savedFile;
        isLoading = false;
      });

      _landLocationBloc.add(LocationImageChanged(savedFile));

      // Get location automatically after taking photo
      await getLocation();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      FlushBarHelper.flushBarErrorMessage("Error taking photo: $e", context);
    }
  }

  Future<void> getLocation() async {
    setState(() {
      isGettingLocation = true;
    });

    try {
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          FlushBarHelper.flushBarErrorMessage(
            "Location permissions are denied",
            context,
          );
          setState(() {
            isGettingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        FlushBarHelper.flushBarErrorMessage(
          "Location permissions are permanently denied, we cannot request permissions.",
          context,
        );
        setState(() {
          isGettingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      await getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        isGettingLocation = false;
      });

      if (e.toString().contains('timeout')) {
        FlushBarHelper.flushBarErrorMessage(
          "Location request timed out. Please try again or enter manually.",
          context,
        );
      } else {
        FlushBarHelper.flushBarErrorMessage(
          "Error getting location: $e",
          context,
        );
      }
    }
  }

  Future<void> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String fullAddress =
            "${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''} ${place.postalCode ?? ''}";

        // Update controllers
        _addressController.text = fullAddress;
        _cityController.text = place.locality ?? '';
        _stateController.text = place.administrativeArea ?? '';
        _pinCodeController.text = place.postalCode ?? '';
        _villageController.text = place.subLocality ?? '';
        _tehsilController.text = place.subAdministrativeArea ?? '';
        _districtController.text = place.locality ?? '';

        // Update BLoC with ALL fields
        _landLocationBloc.add(
          SetLocationFromCoordinates(
            latitude: lat,
            longitude: lng,
            address: fullAddress,
            city: place.locality,
            state: place.administrativeArea,
            pinCode: place.postalCode,
            village: place.subLocality,
            tehsil: place.subAdministrativeArea,
            district: place.locality,
          ),
        );

        // Force a rebuild to show updated values
        setState(() {});
      }
    } catch (e) {
      FlushBarHelper.flushBarErrorMessage("Error getting address: $e", context);
    } finally {
      setState(() {
        isGettingLocation = false;
      });
    }
  }

  void _updateAllFields() {
    _landLocationBloc.add(AddressChanged(_addressController.text));
    _landLocationBloc.add(CityChanged(_cityController.text));
    _landLocationBloc.add(StateChanged(_stateController.text));
    _landLocationBloc.add(PinCodeChanged(_pinCodeController.text));
    _landLocationBloc.add(VillageChanged(_villageController.text));
    _landLocationBloc.add(TehsilChanged(_tehsilController.text));
    _landLocationBloc.add(DistrictChanged(_districtController.text));

    // Make sure latitude and longitude are also updated if available
    if (_landLocationBloc.state.latitude != 0.0) {
      _landLocationBloc.add(LatitudeChanged(_landLocationBloc.state.latitude));
    }
    if (_landLocationBloc.state.longitude != 0.0) {
      _landLocationBloc.add(
        LongitudeChanged(_landLocationBloc.state.longitude),
      );
    }
  }

  void _submitForm() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    _updateAllFields();
    _landLocationBloc.add(SubmitLandLocation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _landLocationBloc,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Set Location',
          automaticallyImplyLeading: true,
          gradient: const LinearGradient(
            colors: [Color(0xff34A853), Color(0xff0D47A1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        body: BlocListener<LandLocationBloc, LandLocationState>(
          listenWhen: (previous, current) =>
              previous.postApiStatus != current.postApiStatus,
          listener: (context, state) {
            if (state.postApiStatus == PostApiStatus.error) {
              FlushBarHelper.flushBarErrorMessage(state.message, context);
            }

            if (state.postApiStatus == PostApiStatus.success) {
              FlushBarHelper.flushBarSuccessMessage(
                state.message.isNotEmpty
                    ? state.message
                    : "Location saved successfully!",
                context,
              );

              // Navigate to next step
              Navigator.pushNamed(
                context,
                RoutesName.uploadLandImageScreen,
                arguments: {'tempId': state.responseTempId},
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Preview Card
                  if (imageFile != null) ...[
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.file(
                                  imageFile!,
                                  height: 250,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Coordinates overlay at bottom left
                              Positioned(
                                bottom: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:
                                      BlocBuilder<
                                        LandLocationBloc,
                                        LandLocationState
                                      >(
                                        builder: (context, state) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                state.latitude != 0 &&
                                                        state.longitude != 0
                                                    ? "${state.latitude.toStringAsFixed(6)}, ${state.longitude.toStringAsFixed(6)}"
                                                    : "Getting location...",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                ),
                              ),
                              // Retake button
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: isLoading ? null : openCamera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_addressController.text.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Color(0xffF5F5F5),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.location_city,
                                    color: Color(0xff34A853),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _addressController.text,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Location Status Card when no image
                  if (imageFile == null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.location_on,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Take a photo of your land to auto-fill location",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "We'll detect your coordinates automatically",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Manual Entry Section
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.edit_location_alt,
                                  color: Color(0xff34A853),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Location Details",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Address
                          CustomTextField(
                            controller: _addressController,
                            hintText: "Full Address",
                            maxLines: 3,
                            onChanged: (value) {
                              _landLocationBloc.add(AddressChanged(value));
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // City and State Row
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _cityController,
                                  hintText: "City",
                                  onChanged: (value) {
                                    _landLocationBloc.add(CityChanged(value));
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'City is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  controller: _stateController,
                                  hintText: "State",
                                  onChanged: (value) {
                                    _landLocationBloc.add(StateChanged(value));
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'State is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // PIN Code
                          CustomTextField(
                            controller: _pinCodeController,
                            hintText: "PIN Code",
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            onChanged: (value) {
                              _landLocationBloc.add(PinCodeChanged(value));
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'PIN code is required';
                              }
                              if (value.length != 6) {
                                return 'Enter valid 6-digit PIN';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Optional Fields Section
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Additional Details (Optional)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Village and Tehsil Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        controller: _villageController,
                                        hintText: "Village",
                                        onChanged: (value) {
                                          _landLocationBloc.add(
                                            DistrictChanged(value),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: CustomTextField(
                                        controller: _tehsilController,
                                        hintText: "Tehsil",
                                        onChanged: (value) {
                                          _landLocationBloc.add(
                                            TehsilChanged(value),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // District
                                CustomTextField(
                                  controller: _districtController,
                                  hintText: "District",
                                  onChanged: (value) {
                                    _landLocationBloc.add(
                                      DistrictChanged(value),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  BlocBuilder<LandLocationBloc, LandLocationState>(
                    buildWhen: (previous, current) =>
                        previous.postApiStatus != current.postApiStatus ||
                        previous.latitude != current.latitude,
                    builder: (context, state) {
                      return Column(
                        children: [
                          // Camera Button (if no image)
                          if (imageFile == null)
                            Container(
                              width: double.infinity,
                              height: 56,
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ElevatedButton.icon(
                                onPressed: isLoading || isGettingLocation
                                    ? null
                                    : openCamera,
                                icon: isLoading || isGettingLocation
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.camera_alt),
                                label: Text(
                                  isLoading || isGettingLocation
                                      ? "Processing..."
                                      : "Take Land Photo",
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff34A853),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),

                          // Submit Button
                          RoundButton(
                            width: double.infinity,
                            buttonColor: AppColors.greenColor,
                            title: state.postApiStatus == PostApiStatus.loading
                                ? "Saving Location..."
                                : "Save & Continue",
                            onPress:
                                state.postApiStatus == PostApiStatus.loading
                                ? null
                                : _submitForm,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
