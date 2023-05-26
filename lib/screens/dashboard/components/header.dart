import 'package:daily_readings_admin_sdk/controllers/global_controller.dart';
import 'package:daily_readings_admin_sdk/helpers/constants.dart';
import 'package:daily_readings_admin_sdk/screens/responsive.dart';
import 'package:daily_readings_admin_sdk/services/auth.dart';
import 'package:daily_readings_admin_sdk/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);
  FirestoreController firestore = Get.find();
  GlobalController globalController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: globalController.openDrawer,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  RxString selectedValue = 'Account'.obs;

  final AuthController auth = AuthController();

  FirestoreController firestore = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(left: defaultPadding),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: const Color.fromRGBO(255, 255, 255, 0.102)),
              ),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/250?image=9',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2),
                      child:
                          Obx(() => Text(firestore.userDataModel.value.email)),
                    ),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                ],
              ),
            ),
            items: [firestore.userDataModel.value.function, 'Account', 'Logout']
                .map((item) => DropdownMenuItem<String>(
                      enabled: [
                            firestore.userDataModel.value.function,
                            'Account',
                            'Logout'
                          ].indexOf(item) !=
                          0,
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: 'Logout',
            onChanged: (value) async {
              selectedValue.value = value.toString();
              if (value == 'Account') Get.toNamed('/account');
              if (value == 'Logout') {
                await auth.logOut();
                Get.offAllNamed('/');
              }
            },
            buttonStyleData: const ButtonStyleData(
              height: 40,
              width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              margin:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
