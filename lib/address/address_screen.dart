import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_main/models/address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  Address address = Address();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
        backgroundColor: Colors.deepPurple.shade600,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          if (isLoading) const LinearProgressIndicator(color: Colors.orange),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onSelect: (country) {
                            address.country = country.name;
                            setState(() {});
                          },
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  address.country ?? "Country",
                                  style: TextStyle(
                                      fontSize: 16.5,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                const Icon(Icons.search_rounded)
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 1.2,
                              width: double.infinity,
                              color: Colors.grey.shade500,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      onChanged: (value) => address.pref = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Prefecture";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: "Prefecture"),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      onChanged: (value) => address.municipality = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Municipality";
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: "Municipality"),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      onChanged: (value) => address.streetAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          //TODO: IMPLEMENT MORE ROBUST VALIDATOR.
                          return "Please enter valid street address";
                        }
                        return null;
                      },
                      decoration:
                          const InputDecoration(hintText: "Street address"),
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      onChanged: (value) => address.apartment = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter apartment";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Apartment, suit or unit"),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade600,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          if (address.country == null ||
                              address.country!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please enter country")));
                          } else {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await Future.delayed(const Duration(seconds: 3));
                              setState(() => isLoading = false);
                            }
                          }
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
