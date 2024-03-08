import 'package:flutter/material.dart';

import '../../../../data/models/term.dart';

class DropDownTerms extends StatefulWidget {
  const DropDownTerms(this.items, this.setTerm, {super.key});
  final List<Term> items;
  final Function(Term newTerm) setTerm;

  @override
  State<DropDownTerms> createState() => _DropDownTermsState();
}

class _DropDownTermsState extends State<DropDownTerms> {

  _DropDownTermsState();
  // Initial Selected Value
  late Term dropdownvalue = widget.items.last;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
        // Initial Value
        value: dropdownvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: widget.items.map((Term item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.name),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (Term? newValue) {
          setState(() {
            dropdownvalue = newValue!;
            widget.setTerm(dropdownvalue);
          });
        },
      ),
    );
  }
}
