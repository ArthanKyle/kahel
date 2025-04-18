import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinput/pinput.dart';
import '../../api/auth.dart';
import '../../constants/colors.dart';
import '../../models/user.dart';
import '../../utils/mpin_hash.dart';
import '../../widgets/universal/auth/arrow_back.dart';
import '../../widgets/universal/auth/auth_info.dart';
import '../../widgets/universal/auth/mpin_button.dart';
import '../../widgets/universal/dialog_info.dart';
import '../../widgets/universal/dialog_loading.dart';

class CreateMPINPage extends StatefulWidget {
  const CreateMPINPage({super.key});

  @override
  State<CreateMPINPage> createState() => _CreateMPINPageState();
}

class _CreateMPINPageState extends State<CreateMPINPage> {
  TextEditingController controller = TextEditingController(text: "");
  final myRegBox = Hive.box("myRegistrationBox");

  late String name = myRegBox.get("fullName");
  late String email = myRegBox.get("email");
  late String birthday = myRegBox.get("birthday");
  late String phoneNumber = myRegBox.get("phoneNumber");
  late String password = myRegBox.get("password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.accentWhite,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            ArrowBack(onTap: () => Navigator.pop(context)),
            const SizedBox(height: 20),
            const AuthInfo(
                headText: "Nominate a MPIN",
                subText: "to ensure your saftey please create your MPIN"),
            const SizedBox(height: 30),
            Pinput(
              length: 4,
              readOnly: false,
              controller: controller,
              autofocus: true,
              defaultPinTheme: PinTheme(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffE8E8E8),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.accentBlack,
                ),
              ),
              focusedPinTheme: PinTheme(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffE8E8E8),
                  border: Border.all(color: ColorPalette.primary, width: 2),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.accentBlack,
                ),
              ),
              onCompleted: (value) async {
                DialogInfo(
                  headerText: "Confirm MPIN",
                  subText: "Are you sure you want to use this as your MPIN?",
                  confirmText: "Confirm",
                  onCancel: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  onConfirm: () async {
                    Navigator.of(context, rootNavigator: true).pop();

                    DialogLoading(subtext: "Creating...").build(context);

                    try {
                      String salt = generateSalt();
                      String hashedMPIN = hashMPIN(value, salt);

                      UserModel user = UserModel(
                        name: name,
                        email: email,
                        mpin: hashedMPIN,
                        birthday: birthday,
                        phoneNumber: phoneNumber,
                        balance: "0",
                        salt: salt,
                        pawKoins: 0,
                        transactionCount: "",
                        lastTransactionDate: "",
                        walletAddress: "",
                        claimedDays: [],
                      );

                      AuthResponse res = await createAccAPI(user: user, password: password);

                      if (!mounted) return;
                      Navigator.of(context, rootNavigator: true).pop();

                      if (res.userCredential == null) {
                        DialogInfo(
                          headerText: "Error",
                          subText: res.errorMessage!,
                          confirmText: "Try again",
                          onCancel: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          onConfirm: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ).build(context);
                        return;
                      }

                      myRegBox.put("fullName", "");
                      myRegBox.put("birthday", "");
                      myRegBox.put("phoneNumber", "");
                      myRegBox.put("email", "");
                      myRegBox.put("password", "");

                      DialogInfo(
                        headerText: "Success!",
                        subText: "You have created an account! Log in now!",
                        confirmText: "Log in",
                        cancelText: "Go back",
                        onCancel: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/login", (route) => false);
                        },
                        onConfirm: () async {
                          Navigator.of(context, rootNavigator: true).pop();
                          DialogLoading(subtext: "Redirecting...").build(context);

                          AuthResponse loginRes =
                          await signIn(email: email, password: password);

                          if (!mounted) return;

                          Navigator.of(context, rootNavigator: true).pop();

                          if (loginRes.userCredential != null) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/enter-mpin", (route) => false);
                          } else {
                            DialogInfo(
                              headerText: "Error",
                              subText: "Cannot log in, please restart the app!",
                              confirmText: "Try again",
                              onCancel: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              onConfirm: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ).build(context);
                          }
                        },
                      ).build(context);
                    } catch (e) {
                      // Dismiss loading and show error dialog in case of failure
                      Navigator.of(context, rootNavigator: true).pop();
                      DialogInfo(
                        headerText: "Error",
                        subText: "Account creation failed. Please try again.",
                        confirmText: "Try again",
                        onCancel: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        onConfirm: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ).build(context);
                    }
                  },
                ).build(context);
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 300,
                child: GridView.count(
                  childAspectRatio: 1.5,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  children: generateNumberButtons(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void enterMPIN(String pin) {
    if (controller.text.length == 4) return;

    setState(() {
      controller.text += pin;
    });
  }

  void deletePIN() {
    if (controller.text.isEmpty) return;

    controller.text = controller.text.substring(0, controller.text.length - 1);
  }

  List<Widget> generateNumberButtons() {
    List<Widget> numberButtons = [];

    for (int i = 1; i <= 9; i++) {
      numberButtons.add(
        MPINBUtton(textName: "$i", onTap: () => enterMPIN("$i")),
      );
    }

    numberButtons.add(const SizedBox()); // Empty space in the last row
    numberButtons.add(
      MPINBUtton(textName: "0", onTap: () => enterMPIN("0")),
    );
    numberButtons.add(
      IconButton(
        onPressed: () => deletePIN(),
        icon: const Icon(
          Icons.backspace,
          color: ColorPalette.primary,
          size: 30,
        ),
      ),
    );

    return numberButtons;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
