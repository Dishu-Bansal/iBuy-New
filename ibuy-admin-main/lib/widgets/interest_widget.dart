import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentication/login_controller.dart';

class InterestListWidget extends StatefulWidget {
  const InterestListWidget({super.key});
  @override
  _InterestListWidgetState createState() => _InterestListWidgetState();
}

class _InterestListWidgetState extends State<InterestListWidget> {
  bool widgetCreated = false;

  @override
  void initState() {
    widgetCreated = true;
    super.initState();
  }

  final loginController = Get.put(LoginController());

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  //final projectController = Get.put(ProjectController());

  void _addInterest(String interest) {
    setState(() {
      loginController.retailers.add(interest);
      _textEditingController.clear();
    });
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _removeInterest(String interest) {
    setState(() {
      loginController.retailers.remove(interest);
    });
  }

  //keywords

  // void _addKeyword(keyword) {
  //   setState(() {
  //     projectController.keywords.add(keyword);
  //     _keywords.clear();
  //   });
  //   FocusScope.of(context).requestFocus(_keywordsFocus);
  // }

  // void _removeKeyowrd(String keyword) {
  //   setState(() {
  //     projectController.keywords.remove(keyword);
  //   });
  // }

  // //members
  // void _addMember(keyword) {
  //   setState(() {
  //     projectController.members.add(keyword);
  //     _members.clear();
  //   });
  //   FocusScope.of(context).requestFocus(_membersFocus);
  // }

  // void _removeMember(String keyword) {
  //   setState(() {
  //     projectController.members.remove(keyword);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print(loginController.retailers);
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Text('Interests'),
          //SizedBox(height: 10),

          TextFormField(
            controller: _textEditingController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: "Enter Retailers",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                _addInterest(value);
              }
            },
          ),
          const SizedBox(height: 15),
          if (loginController.retailers.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: loginController.retailers.map((interest) {
                  return Chip(
                    label: Text(interest),
                    deleteIcon: const Icon(Icons.cancel),
                    onDeleted: () {
                      _removeInterest(interest);
                    },
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
