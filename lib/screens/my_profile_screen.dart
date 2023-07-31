import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'My Profile',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'images/User.png',
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  'Change Photo',
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'First Name',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: w / 3,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Rahul',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Last Name',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: w / 3,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Verma',
                              hintStyle:
                                  TextStyle(color: Colors.black, fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'E-mail',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 330,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'stoild@email.com',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 330,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '8094XXXXXX',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Gender',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 330,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Male',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 19),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Center(
                child: SizedBox(
                  width: 240,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: Image.asset(
            "images/line chart.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
