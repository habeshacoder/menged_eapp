import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/miscellaneous.dart';

class DropDownList extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final bool isCitySelected;
  final List<SelectedListItem>? cities;
  final initialValue;
  final Icon? icon;

  const DropDownList({
    required this.textEditingController,
    required this.title,
    required this.isCitySelected,
    this.initialValue,
    this.cities,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        listItemBuilder: (index) {
          return ListTile(
            dense: true,
            title: Text(
              widget.cities![index].name,
              style: TextStyle(fontSize: 12),
            ),
            leading: Icon(Icons.location_city),
          );
        },
        data: widget.cities ?? [],
        selectedItems: (List<SelectedListItem> selectedList) {
          setState(() {
            widget.textEditingController.text = selectedList[0].name;
          });
          print(selectedList[0].value);
          if (widget.title == "Departure") {
            context
                .read<Miscellaneous>()
                .changeDeparture(selectedList[0].value);
          }
          if (widget.title == "Destination") {
            context
                .read<Miscellaneous>()
                .changeDestination(selectedList[0].value);
          }
        },
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    // widget.textEditingController.text =
    //     widget.cities![widget.initialValue].name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: widget.textEditingController,
          style: TextStyle(fontSize: 12),
          cursorColor: Colors.black,
          onTap: widget.isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            hintText: widget.title,
            prefixIcon: widget.icon,
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
