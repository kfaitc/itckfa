import 'package:flutter/material.dart';
import '../../contants.dart';
import '../../screen/components/map_all/map_in_add_verbal.dart';
import 'colors.dart';

class OptionRoadNew extends StatefulWidget {
  const OptionRoadNew(
      {super.key,
      required this.pwidth,
      required this.list,
      required this.valueId,
      required this.valueName,
      required this.lable,
      required this.onbackValue,
      required this.hight});
  final double pwidth;
  final List list;
  final String valueId;
  final String valueName;
  final String lable;
  final double hight;
  final OnChangeCallback onbackValue;

  @override
  State<OptionRoadNew> createState() => _OptionRoadNewState();
}

class _OptionRoadNewState extends State<OptionRoadNew> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.hight,
      width: widget.pwidth,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        onChanged: (newValue) {
          setState(() {
            widget.onbackValue(newValue);
          });
        },
        items: widget.list
            .map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: "${value[widget.valueId]},${value[widget.valueName]}",
                child: Text(value[widget.valueName].toString()),
              ),
            )
            .toList(),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kImageColor,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          fillColor: Colors.white,
          filled: true,
          labelText: widget.lable,
          hintStyle: TextStyle(
              color: blackColor, fontWeight: FontWeight.bold, fontSize: 12),
          hintText: 'Select one',
          prefixIcon: const Icon(
            Icons.edit_road_outlined,
            color: kImageColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
