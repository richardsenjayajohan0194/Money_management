// modal_dialog_template.dart
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_management/app/utils/Widget/Textfield.dart';

import '../../controllers/firestore_controller.dart';
import '../../model/bank_model.dart';

class DropdownTemplate extends StatefulWidget {
  DropdownTemplate({
    Key? key,
  }) : super(key: key);

  @override
  _DropdownTemplateState createState() => _DropdownTemplateState();
}

class _DropdownTemplateState extends State<DropdownTemplate> {
  final firestoreF = Get.find<FirestoreController>();

  List<String> items = []; // Initialize items list

  String? selectedValue;
  String customValue = '';
  bool isOtherSelected = false;
  double dropdownWidth = 0.74;

  @override
  void initState() {
    super.initState();
    _loadBankData(); // Load bank data when the widget is initialized
  }

  Future<void> _loadBankData() async {
    List<BankModel> bankDataList = await firestoreF.getDataBanks();

    // Debugging line to check the contents of bankDataList
    print("Bank Data List: $bankDataList");

    setState(() {
      items = [
        ...bankDataList
            .map((bankData) => bankData.bank ?? 'Unknown Bank')
            .toList(),
        'Other'
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                  if (value == 'Other') {
                    isOtherSelected = true;
                    dropdownWidth = 0.239;
                  } else {
                    isOtherSelected = false;
                    dropdownWidth = 0.5;
                  }
                });
              },
              buttonStyleData: ButtonStyleData(
                height: 50,
                width: MediaQuery.of(context).size.width * dropdownWidth,
                padding: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.black26,
                  ),
                  color: Colors.redAccent,
                ),
                elevation: 2,
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                iconEnabledColor: Colors.yellow,
                iconDisabledColor: Colors.grey,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 700,
                width: MediaQuery.of(context).size.width * dropdownWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.redAccent,
                ),
                offset: Offset(0, 0), // Center the dropdown
                scrollbarTheme: ScrollbarThemeData(
                  radius: Radius.circular(20.0),
                  thickness: MaterialStateProperty.all<double>(
                      0), // Set thickness to 0 to hide scrollbar
                  thumbVisibility: MaterialStateProperty.all<bool>(
                      false), // Set thumb visibility to false
                  thumbColor: MaterialStateProperty.all<Color>(
                      Colors.transparent), // Set thumb color to transparent
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
        ),
        isOtherSelected
            ? SizedBox(
                width: 10,
              )
            : SizedBox(
                width: 0,
              ),
        isOtherSelected
            ? Expanded(
                flex: 2,
                child: TextfieldTemplate(
                  hintText: 'Enter custom value',
                  useMargin: false,
                  useOutlineBorder: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
