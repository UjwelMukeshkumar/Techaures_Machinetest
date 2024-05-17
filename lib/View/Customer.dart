import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:req/View/HomeScreen.dart';
import 'package:req/View/cartpage.dart';
import 'package:req/color.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<dynamic> customers = [];
  List<dynamic> filteredCustomers = [];

  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController profilePicController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController streetTwoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    final response =
        await http.get(Uri.parse('http://143.198.61.94:8000/api/customers/'));
    if (response.statusCode == 200) {
      setState(() {
        customers = json.decode(response.body)['data'];
        filteredCustomers = customers;
      });
    } else {
      throw Exception('Failed to load customers');
    }
  }

  Future<void> searchCustomers(String query) async {
    final response = await http.get(Uri.parse(
        'http://143.198.61.94:8000/api/customers/?search_query=$query'));
    if (response.statusCode == 200) {
      setState(() {
        filteredCustomers = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to search customers');
    }
  }

  Future<void> createCustomer(
      String name,
      String profilePic,
      String mobileNumber,
      String email,
      String street,
      String streetTwo,
      String city,
      String pincode,
      String country,
      String state) async {
    try {
      final response = await http.post(
        Uri.parse('http://143.198.61.94:8000/api/customers/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'profile_pic': profilePic,
          'mobile_number': mobileNumber,
          'email': email,
          'street': street,
          'street_two': streetTwo,
          'city': city,
          'pincode': pincode,
          'country': country,
          'state': state,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['error_code'] == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Customer created successfully'),
              backgroundColor: Colors.green,
            ),
          );
          fetchCustomers();
          Navigator.pop(context);
        } else {
          throw Exception('Failed to create customer');
        }
      } else {
        throw Exception('Failed to create customer');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create customer'),
          backgroundColor: Colors.red,
        ),
      );
      throw Exception('Failed to create customer');
    }
  }

  Future<void> updateCustomer(
      String id,
      String name,
      String profilePic,
      String mobileNumber,
      String email,
      String street,
      String streetTwo,
      String city,
      String pincode,
      String country,
      String state) async {
    final response = await http.put(
      Uri.parse('http://143.198.61.94:8000/api/customers/?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'profile_pic': profilePic,
        'mobile_number': mobileNumber,
        'email': email,
        'street': street,
        'street_two': streetTwo,
        'city': city,
        'pincode': pincode,
        'country': country,
        'state': state,
      }),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['error_code'] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Customer updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        fetchCustomers(); // Assuming fetchCustomers is a method in your controller to refresh the customer list
        Navigator.pop(context); // Assuming context is available here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update customer'),
            backgroundColor: Colors.red,
          ),
        );
        throw Exception('Failed to update customer');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update customer'),
          backgroundColor: Colors.red,
        ),
      );
      throw Exception('Failed to update customer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Customers', textAlign: TextAlign.center),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                searchCustomers(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        fetchCustomers();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.grid_on),
                      onPressed: () {
                        // Implement grid action here
                      },
                    ),
                    Container(
                      height: 30.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 15,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Create New Customer'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                          labelText: 'Name',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: profilePicController,
                                        decoration: const InputDecoration(
                                          labelText: 'Profile Pic',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: mobileNumberController,
                                        decoration: const InputDecoration(
                                          labelText: 'Mobile Number',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: streetController,
                                        decoration: const InputDecoration(
                                          labelText: 'Street',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: streetTwoController,
                                        decoration: const InputDecoration(
                                          labelText: 'Street Two',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: cityController,
                                        decoration: const InputDecoration(
                                          labelText: 'City',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: pincodeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Pincode',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: countryController,
                                        decoration: const InputDecoration(
                                          labelText: 'Country',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                      TextField(
                                        controller: stateController,
                                        decoration: const InputDecoration(
                                          labelText: 'State',
                                        ),
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      createCustomer(
                                        nameController.text,
                                        profilePicController.text,
                                        mobileNumberController.text,
                                        emailController.text,
                                        streetController.text,
                                        streetTwoController.text,
                                        cityController.text,
                                        pincodeController.text,
                                        countryController.text,
                                        stateController.text,
                                      );
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCustomers.length,
              itemBuilder: (BuildContext context, int index) {
                final customer = filteredCustomers[index];
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'http://143.198.61.94:8000${customer['profile_pic'] ?? ''}',
                      ),
                      child: customer['profile_pic'] == null
                          ? Image.asset(
                              'assets/profile.png') // Replace 'assets/placeholder_image.jpg' with your static image path
                          : null,
                    ),
                    title: Text(
                      customer['name'] ?? '',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Text('ID: ${customer['id'].toString()}'),
                        Text(
                            '${customer['street'] ?? ''}, ${customer['city'] ?? ''}'),
                      ],
                    ),
                    trailing: Positioned(
                      top: 1,
                      left: 2,
                      bottom: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.call),
                            iconSize: 10,
                            onPressed: () {
                              // Implement calling functionality
                            },
                          ),
                          IconButton(
                            icon: Image.asset(
                              'assets/whatsapp.png',
                              height: 10,
                            ), // Replace with your WhatsApp icon

                            onPressed: () {
                              // Implement WhatsApp functionality
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            iconSize: 10,
                            onPressed: () {
                              //dialob box for update the customer
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Update Customer'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                              hintText: customer['name'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: profilePicController,
                                            decoration: InputDecoration(
                                              labelText: 'Profile Pic',
                                              hintText:
                                                  customer['profile_pic'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: mobileNumberController,
                                            decoration: InputDecoration(
                                              labelText: 'Mobile Number',
                                              hintText:
                                                  customer['mobile_number'] ??
                                                      '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              hintText: customer['email'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: streetController,
                                            decoration: InputDecoration(
                                              labelText: 'Street',
                                              hintText:
                                                  customer['street'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: streetTwoController,
                                            decoration: InputDecoration(
                                              labelText: 'Street Two',
                                              hintText:
                                                  customer['street_two'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: cityController,
                                            decoration: InputDecoration(
                                              labelText: 'City',
                                              hintText: customer['city'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: pincodeController,
                                            decoration: InputDecoration(
                                              labelText: 'Pincode',
                                              hintText: customer['pincode']
                                                      ?.toString() ??
                                                  '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: countryController,
                                            decoration: InputDecoration(
                                              labelText: 'Country',
                                              hintText:
                                                  customer['country'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          TextField(
                                            controller: stateController,
                                            decoration: InputDecoration(
                                              labelText: 'State',
                                              hintText: customer['state'] ?? '',
                                            ),
                                            onChanged: (value) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          updateCustomer(
                                            customer['id']?.toString() ?? '',
                                            nameController.text,
                                            profilePicController.text,
                                            mobileNumberController.text,
                                            emailController.text,
                                            streetController.text,
                                            streetTwoController.text,
                                            cityController.text,
                                            pincodeController.text,
                                            countryController.text,
                                            stateController.text,
                                          );
                                        },
                                        child: const Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
