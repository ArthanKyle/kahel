import 'package:flutter/material.dart';

import '../../../constants/borders.dart';
import '../../../constants/colors.dart';

class PetNameDropdown extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final List<String> petNames;

  const PetNameDropdown({
    super.key,
    required this.labelText,
    required this.controller,
    required this.petNames,
  });

  @override
  State<PetNameDropdown> createState() => _PetNameDropdownState();
}

class _PetNameDropdownState extends State<PetNameDropdown> {
  String? selectedPet;

  @override
  void initState() {
    super.initState();
    selectedPet = widget.controller.text; // Initialize selectedPet with the controller's text
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
            color: ColorPalette.accentBlack,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedPet!.isNotEmpty ? selectedPet : null, // Handle null values
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              selectedPet = value;
              widget.controller.text = value; // Update the controller's text
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) return "Please select pet.";
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18.5),
            enabledBorder: Inputs.enabledBorder,
            focusedBorder: Inputs.focusedBorder,
            errorBorder: Inputs.errorBorder,
            focusedErrorBorder: Inputs.errorBorder,
            filled: true,
            fillColor: ColorPalette.bgColor,
            errorStyle: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.normal,
              color: ColorPalette.errorColor,
              fontSize: 12,
            ),
          ),
          items: widget.petNames.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: ColorPalette.accentBlack,
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
