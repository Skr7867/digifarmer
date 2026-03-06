import 'package:digifarmer/main.dart';
import 'package:digifarmer/res/customeWidgets/custom_textfield.dart';
import 'package:digifarmer/res/customeWidgets/round_button.dart';
import 'package:digifarmer/utils/enums.dart';
import 'package:digifarmer/utils/flush_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/LANDOWNERPANEL/basicInfo/basic_info_bloc.dart';
import '../../../config/routes/routes_name.dart';
import '../../../repository/LANDOWNERPANEL/saveBasicInfo/save_basic_info_repository.dart';
import '../../../res/color/app_colors.dart';

class AddNewLandScreen extends StatefulWidget {
  final String? uniqueKey;

  const AddNewLandScreen({super.key, this.uniqueKey});

  @override
  State<AddNewLandScreen> createState() => _AddNewLandScreenState();
}

class _AddNewLandScreenState extends State<AddNewLandScreen> {
  late final SaveBasicInfoBloc _saveBasicInfoBloc;

  // Controllers
  final _landTitleController = TextEditingController();
  final _surveyNumberController = TextEditingController();
  final _areaValueController = TextEditingController();
  final _totalSizeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _soilTypeController = TextEditingController();
  final _expectedMonthlyRentController = TextEditingController();
  final _minimumLeaseDurationController = TextEditingController();

  // Water source states
  bool borewell = false;
  bool canal = false;
  bool openWell = false;
  bool rainwater = false;

  // Selected area unit
  String _selectedAreaUnit = 'ACRE';
  final List<String> _areaUnits = ['ACRE', 'HECTARE', 'SQFT', 'SQMT'];

  @override
  void initState() {
    super.initState();
    _saveBasicInfoBloc = SaveBasicInfoBloc(getIt<SaveBasicInfoRepository>());

    if (widget.uniqueKey != null) {
      _saveBasicInfoBloc.add(SetUniqueKey(widget.uniqueKey!));
    }
  }

  @override
  void dispose() {
    _saveBasicInfoBloc.close();
    _landTitleController.dispose();
    _surveyNumberController.dispose();
    _areaValueController.dispose();
    _totalSizeController.dispose();
    _descriptionController.dispose();
    _soilTypeController.dispose();
    _expectedMonthlyRentController.dispose();
    _minimumLeaseDurationController.dispose();
    super.dispose();
  }

  List<String> _getSelectedWaterSources() {
    List<String> sources = [];
    if (borewell) sources.add('BOREWELL');
    if (canal) sources.add('CANAL');
    if (openWell) sources.add('OPEN_WELL');
    if (rainwater) sources.add('RAINWATER');
    return sources;
  }

  void _updateWaterSources() {
    _saveBasicInfoBloc.add(WaterSourceChanged(_getSelectedWaterSources()));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _saveBasicInfoBloc,
      child: Scaffold(
        backgroundColor: const Color(0xfff4f5f7),
        body: BlocListener<SaveBasicInfoBloc, SaveBasicInfoState>(
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
                    : "Land information saved successfully!",
                context,
              );

              // Navigate to next step or show success

              Navigator.pushNamed(
                context,
                RoutesName.locationScreen,
                arguments: state.tempId,
              );
            }
          },
          child: Column(
            children: [
              /// HEADER
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xff2FA66A),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      "Add New Land",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.map, color: Colors.white),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Register Your Land\nComplete the form to add your property",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Registration Progress",
                          style: TextStyle(color: Colors.white),
                        ),
                        BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                          builder: (context, state) {
                            return Text(
                              "Step ${state.currentStep} of 3",
                              style: const TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.33,
                        backgroundColor: Colors.white24,
                        color: Colors.white,
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),

              /// FORM
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      children: [
                        /// BASIC INFO
                        _sectionCard(
                          title: "Basic Information",
                          children: [
                            BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _surveyNumberController,
                                  hintText: "Khasra/Survey Number",
                                  onChanged: (value) {
                                    context.read<SaveBasicInfoBloc>().add(
                                      SurveyNumberChanged(value),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Survey number is required';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child:
                                      BlocBuilder<
                                        SaveBasicInfoBloc,
                                        SaveBasicInfoState
                                      >(
                                        builder: (context, state) {
                                          return CustomTextField(
                                            controller: _areaValueController,
                                            hintText: "Enter area",
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              final area =
                                                  double.tryParse(value) ?? 0.0;
                                              context
                                                  .read<SaveBasicInfoBloc>()
                                                  .add(AreaValueChanged(area));
                                              // Auto-update total size if needed
                                              context
                                                  .read<SaveBasicInfoBloc>()
                                                  .add(TotalSizeChanged(area));
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Area is required';
                                              }
                                              return null;
                                            },
                                          );
                                        },
                                      ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child:
                                      BlocBuilder<
                                        SaveBasicInfoBloc,
                                        SaveBasicInfoState
                                      >(
                                        builder: (context, state) {
                                          return DropdownButtonFormField<
                                            String
                                          >(
                                            initialValue: _selectedAreaUnit,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(
                                                0xfff7f7f7,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                            ),
                                            items: _areaUnits.map((unit) {
                                              return DropdownMenuItem(
                                                value: unit,
                                                child: Text(unit),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  _selectedAreaUnit = value;
                                                });
                                                context
                                                    .read<SaveBasicInfoBloc>()
                                                    .add(
                                                      AreaUnitChanged(value),
                                                    );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        /// FARMING DETAILS
                        _sectionCard(
                          title: "Farming Details",
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Water Source",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              children: [
                                _checkbox("Borewell", borewell, (v) {
                                  setState(() {
                                    borewell = v!;
                                    _updateWaterSources();
                                  });
                                }),
                                _checkbox("Canal", canal, (v) {
                                  setState(() {
                                    canal = v!;
                                    _updateWaterSources();
                                  });
                                }),
                                _checkbox("Open Well", openWell, (v) {
                                  setState(() {
                                    openWell = v!;
                                    _updateWaterSources();
                                  });
                                }),
                                _checkbox("Rainwater", rainwater, (v) {
                                  setState(() {
                                    rainwater = v!;
                                    _updateWaterSources();
                                  });
                                }),
                              ],
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _landTitleController,
                                  hintText: "Land Title",
                                  onChanged: (value) {
                                    context.read<SaveBasicInfoBloc>().add(
                                      SoilTypeChanged(value),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _soilTypeController,
                                  hintText: "Soil Type",
                                  onChanged: (value) {
                                    context.read<SaveBasicInfoBloc>().add(
                                      SoilTypeChanged(value),
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _descriptionController,
                                  hintText: "Land Description",
                                  maxLines: 3,
                                  onChanged: (value) {
                                    context.read<SaveBasicInfoBloc>().add(
                                      DescriptionChanged(value),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                        /// LEASE
                        _sectionCard(
                          title: "Lease Preferences",
                          children: [
                            BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _expectedMonthlyRentController,
                                  hintText: "Expected Monthly Rent (₹)",
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    final rent = double.tryParse(value) ?? 0.0;
                                    context.read<SaveBasicInfoBloc>().add(
                                      ExpectedMonthlyRentChanged(rent),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Monthly rent is required';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                              builder: (context, state) {
                                return CustomTextField(
                                  controller: _minimumLeaseDurationController,
                                  hintText: "Minimum lease duration (months)",
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    final duration = int.tryParse(value) ?? 12;
                                    context.read<SaveBasicInfoBloc>().add(
                                      MinimumLeaseDurationChanged(duration),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Lease duration is required';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// BUTTONS
                        BlocBuilder<SaveBasicInfoBloc, SaveBasicInfoState>(
                          buildWhen: (previous, current) =>
                              previous.postApiStatus != current.postApiStatus,
                          builder: (context, state) {
                            return Row(
                              children: [
                                // Expanded(
                                //   child: RoundButton(
                                //     buttonColor: AppColors.greyColor,
                                //     title:
                                //         state.postApiStatus ==
                                //             PostApiStatus.loading
                                //         ? "Saving..."
                                //         : 'Save Draft',
                                //     onPress:
                                //         state.postApiStatus ==
                                //             PostApiStatus.loading
                                //         ? null
                                //         : () {
                                //             _updateAllFields(context);
                                //             context
                                //                 .read<SaveBasicInfoBloc>()
                                //                 .add(SaveDraftBasicInfo());
                                //           },
                                //   ),
                                // ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: RoundButton(
                                    buttonColor: AppColors.greenColor,
                                    title:
                                        state.postApiStatus ==
                                            PostApiStatus.loading
                                        ? 'Please wait...'
                                        : 'Continue',
                                    onPress:
                                        state.postApiStatus ==
                                            PostApiStatus.loading
                                        ? null
                                        : () {
                                            _updateAllFields(context);
                                            context
                                                .read<SaveBasicInfoBloc>()
                                                .add(SubmitSaveBasicInfo());
                                          },
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }

  void _updateAllFields(BuildContext context) {
    context.read<SaveBasicInfoBloc>().add(
      LandTitleChanged(_landTitleController.text),
    );
    context.read<SaveBasicInfoBloc>().add(
      SurveyNumberChanged(_surveyNumberController.text),
    );

    final areaValue = double.tryParse(_areaValueController.text) ?? 0.0;
    context.read<SaveBasicInfoBloc>().add(AreaValueChanged(areaValue));
    context.read<SaveBasicInfoBloc>().add(AreaUnitChanged(_selectedAreaUnit));

    final totalSize = double.tryParse(_totalSizeController.text) ?? areaValue;
    context.read<SaveBasicInfoBloc>().add(TotalSizeChanged(totalSize));

    context.read<SaveBasicInfoBloc>().add(
      DescriptionChanged(_descriptionController.text),
    );
    context.read<SaveBasicInfoBloc>().add(
      SoilTypeChanged(_soilTypeController.text),
    );

    _updateWaterSources();

    context.read<SaveBasicInfoBloc>().add(
      RoadAccessChanged(true), // Set based on your UI if you add this field
    );

    final rent = double.tryParse(_expectedMonthlyRentController.text) ?? 0.0;
    context.read<SaveBasicInfoBloc>().add(ExpectedMonthlyRentChanged(rent));

    final duration = int.tryParse(_minimumLeaseDurationController.text) ?? 12;
    context.read<SaveBasicInfoBloc>().add(
      MinimumLeaseDurationChanged(duration),
    );
  }

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _checkbox(String text, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(text),
      ],
    );
  }
}
