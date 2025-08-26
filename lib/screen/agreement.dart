import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:matchme/constant.dart';
import 'package:matchme/controller/agreement_controller.dart';
import 'package:matchme/widgets/details_hero.dart';
import 'package:matchme/widgets/registration_bottom_buttons.dart';
import 'package:provider/provider.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.3),
        child: DetailsHero(
          size: size,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.01,
          ),
          children: [
            Text(
              "Upload agreement",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: Constant.haddingFont,
              ),
            ),
            const SizedBox(height: 20.0),
            InkWell(
              onTap: () {
                Provider.of<AgreementController>(context, listen: false)
                    .pickedAgreement(context);
              },
              child: DottedBorder(
                dashPattern: const [10, 3],
                color: const Color.fromARGB(255, 168, 171, 172),
                strokeWidth: 1.0,
                borderType: BorderType.RRect,
                radius: const Radius.circular(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          size: 35.0,
                        ),
                        Text(
                          Provider.of<AgreementController>(
                            context,
                            listen: true,
                          ).filename,
                          style: const TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: const Color(0xFF033A44),
              textColor: Colors.white,
              onPressed: () {
                Provider.of<AgreementController>(context, listen: false)
                    .downloadAgreement(context);
              },
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_for_offline),
                    SizedBox(width: 10.0),
                    Text("Download Agreement"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: RegistrationBottomButtons(
        onNextTap: () {
          Provider.of<AgreementController>(context, listen: false)
              .uploadAgreement(context);
        },
        onBackTap: () {},
      ),
    );
  }
}
