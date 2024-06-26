import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/constants.dart';
import 'package:ibuy_admin_app/receipt_controller.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';

class ProcessReceiptScreen extends StatelessWidget {
  const ProcessReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final receiptController = Get.put(ReceiptController());
    print(receiptController.cards);
    final formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: FutureBuilder(
              future: receiptController.getReceiptModals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                } else {
                  if (receiptController.pendingReceipts.length == 0) {
                    return Center(
                      child: Text("No receipts to Process!"),
                    );
                  } else {
                    return Form(
                      key: formKey,
                      child: Row(
                        children: [
                          SizedBox(
                              width: 300,
                              child: Obx(
                                () => Text(
                                    "Customer ID: ${receiptController.customerId}"),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: receiptController.retailerName,
                              cursorColor: Colors.black45,
                              readOnly: true,
                              // initialValue: receiptController.retailer,
                              decoration: InputDecoration(
                                labelText: "Retailer Name",
                                //border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle:
                                    const TextStyle(color: Colors.black45),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field cannot be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: receiptController.trxDate,
                              keyboardType: TextInputType.datetime,
                              cursorColor: Colors.black45,
                              decoration: InputDecoration(
                                labelText: "Transaction Date (DD/MM/YYYY)",
                                //border: OutlineInputBorder(),
                                fillColor: Colors.white,

                                filled: true,
                                labelStyle:
                                    const TextStyle(color: Colors.black45),

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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field cannot be empty";
                                }
                                try {
                                  var format = DateFormat("dd/MM/yyyy");
                                  var start = format.parse(
                                      receiptController.start!);
                                  var end = format.parse(
                                      receiptController.end!);
                                  var current = format.parse(value);

                                  if (current.isAfter(end) ||
                                      current.isBefore(start)) {
                                    return "Date must be between plan dates";
                                  }
                                }
                                catch (e)
                                {
                                  return "DateFormat error";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: receiptController.totalSpend,
                              cursorColor: Colors.black45,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.attach_money_outlined),
                                labelText: "Total Spend",
                                //border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle:
                                    const TextStyle(color: Colors.black45),

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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field cannot be empty";
                                }
                                if(!value.isNum)
                                  {
                                    return "Invalid Number";
                                  }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                      Flexible(
                        child: TypeAheadField<String>(
                          suggestionsCallback: (search) => receiptController.cards,
                          builder: (context, controller, focusNode) {
                            return TextFormField(
                                controller: receiptController.last4Digits,
                                focusNode: focusNode,
                                cursorColor: Colors.black45,
                                decoration: InputDecoration(
                                labelText: "Last 4 digits",
                                //border: OutlineInputBorder(),
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle:
                                    const TextStyle(color: Colors.black45),
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
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Field cannot be empty";
                                }
                                if(!value.isNum)
                                  {
                                    return "Field must only have numbers";
                                  }
                                if(value.length != 4)
                                  {
                                    return "Must be 4 digits";
                                  }
                                if(receiptController.cards.length >= 3 && !receiptController.cards.contains(value))
                                  {
                                    return "Maximum Card limit reached";
                                  }
                                return null;
                              },
                            );
                          },
                          itemBuilder: (context, card) {
                            return ListTile(
                              title: Text(card),
                            );
                          }, onSelected: (String value) {
                            receiptController.last4Digits.value = TextEditingValue(text: value);
                        },
                        ),
                      ),
                          // Flexible(
                          //   child: TextFormField(
                          //     controller: receiptController.last4Digits,
                          //     cursorColor: Colors.black45,
                          //     decoration: InputDecoration(
                          //       labelText: "Last 4 digits",
                          //       //border: OutlineInputBorder(),
                          //       fillColor: Colors.white,
                          //       filled: true,
                          //       labelStyle:
                          //           const TextStyle(color: Colors.black45),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(35.0),
                          //         borderSide: const BorderSide(
                          //           color: Colors.grey,
                          //         ),
                          //       ),
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(35.0),
                          //         borderSide: const BorderSide(
                          //           color: Colors.grey,
                          //         ),
                          //       ),
                          //     ),
                          //     validator: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return "Field cannot be empty";
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  }
                }
              }),
        ),

        Expanded(
          child: Obx(
            () => receiptController.currReceiptUrl.value == ""
                ? const Icon(Icons.no_transfer_outlined)
                : ImageNetwork(image: receiptController.currReceiptUrl.value, height: 500, width: 500, fitWeb: BoxFitWeb.fill,)
          ),
        ),
        const SizedBox(height: 20),
        //borderd button saying next receipt with white background anf black border and text
        ElevatedButton(
          onPressed: () {
            receiptController.nextReceipt();
          },
          style: ElevatedButton.styleFrom(
            elevation: 1,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("Next Receipt"),
          ),
        ),

        //2 button in a row with text saying approve andd reject respectively
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                //width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff35BF84),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              try{
                                receiptController.approveReceipt();
                              }
                              catch (e){
                                showToast(e.toString(), context);
                              }
                            }
                          },
                          child: Row(
                            children: const [
                              Text(
                                "APPROVE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        String reason="";
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text("Select Reason"),
                            content: DropdownButtonFormField(
                                hint: Text("Select Reason"),
                                items: ["Transaction date invalid (the date range for the plan was xxx-to-yyy, but the transaction was made on zzzz)", "Credit card not associated with the account", "Receipt does not belong to the selected retailer"].map((val) => DropdownMenuItem<String>(child: Text(val), value: val,)).toList(),
                                onChanged: (value) {
                                  reason = value ?? "";
                                }),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  try {
    receiptController.rejectReceipt(reason);
    }catch (e) {
                                    showToast(e.toString(), context);

                                  }},
                                child: Text("Reject", style: TextStyle(color: Colors.white),),
                                color: Colors.red,
                              ),
                              MaterialButton(onPressed: () {Navigator.of(context).pop();}, child: Text("Cancel"),),
                            ],
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffE64141),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: const [
                              Text(
                                "REJECT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     receiptController.reUpload();
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: const Color.fromARGB(255, 241, 147, 17),
                    //       borderRadius: BorderRadius.circular(50),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 15, vertical: 10),
                    //       child: Row(
                    //         children: const [
                    //           Text(
                    //             "Request ReUpload",
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 15,
                    //                 fontWeight: FontWeight.w500),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropDownField extends StatefulWidget {
  ReceiptController? receiptController;
  DropDownField(ReceiptController? receiptController, {super.key});

  @override
  State<DropDownField> createState() => _DropDownFieldState(receiptController);
}

class _DropDownFieldState extends State<DropDownField> {
  String _selectedValue = "";
  ReceiptController? receiptController;

  _DropDownFieldState(ReceiptController? receiptController);
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedValue,
      items: receiptController?.cards.map((value) => DropdownMenuItem(child: Text(value))).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value!;
        });
      },
    );
  }
}

