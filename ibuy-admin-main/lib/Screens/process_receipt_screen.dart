import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibuy_admin_app/constants.dart';
import 'package:ibuy_admin_app/receipt_controller.dart';

class ProcessReceiptScreen extends StatelessWidget {
  const ProcessReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final receiptController = Get.put(ReceiptController(), permanent: true);
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
                              labelText: "Transaction Date (DD-MM-YYYY)",
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
                            controller: receiptController.totalSpend,
                            cursorColor: Colors.black45,
                            decoration: InputDecoration(
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
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextFormField(
                            controller: receiptController.last4Digits,
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
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ),

        Expanded(
          child: Obx(
            () => receiptController.currReceiptUrl.value == ""
                ? const Icon(Icons.no_transfer_outlined)
                : Image.network(
                    receiptController.currReceiptUrl.value,
                    /*height: 400,
                width: 800,*/
                    fit: BoxFit.fill,
                  ),
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
                              receiptController.approveReceipt();
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
                        receiptController.rejectReceipt();
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
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        receiptController.reUpload();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 147, 17),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: const [
                              Text(
                                "Request ReUpload",
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
