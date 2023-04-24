import 'package:flutter/material.dart';
import 'package:rumah_kreatif_toba/base/custom_loader.dart';
import 'package:rumah_kreatif_toba/controllers/auth_controller.dart';
import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/pages/account/account_widget.dart';
import 'package:rumah_kreatif_toba/pages/toko/profil/profil.dart';
import 'package:rumah_kreatif_toba/utils/colors.dart';
import 'package:rumah_kreatif_toba/utils/dimensions.dart';
import 'package:rumah_kreatif_toba/widgets/app_icon.dart';
import 'package:rumah_kreatif_toba/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../../routes/route_helper.dart';
import '../../../widgets/small_text.dart';

class ProfilTokoPage extends StatelessWidget {
  const ProfilTokoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<UserController>(
      builder: (userController) {
        return userController.isLoading
            ? CustomLoader()
            : Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: Dimensions.height20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height30,
                              bottom: Dimensions.height10),
                          padding: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: BigText(
                                  text: "Profil Toko",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.redColor,
                        iconColor: Colors.white,
                        iconSize: 65,
                        size: Dimensions.height15 * 8,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Container(
                        child: Column(
                          children: [
                            BigText(
                                text: userController.users.username.toString()),
                            SmallText(
                                text: userController.users.email.toString()),
                            SmallText(
                                text: userController.users.noHp.toString())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Profil
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            Get.to(Profil());
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.store,
                              backgroundColor: Colors.white.withOpacity(0.0),
                              iconColor: AppColors.redColor,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: "Profil",
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Alamat
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            Get.toNamed(
                              RouteHelper.getDaftarAlamatPage(),
                            );
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.location_on_outlined,
                              backgroundColor: Colors.white.withOpacity(0.0),
                              iconColor: AppColors.redColor,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: "Alamat",
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Rekening
                      GestureDetector(
                        onTap: () {
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.account_balance_wallet_outlined,
                              backgroundColor: Colors.white.withOpacity(0.0),
                              iconColor: AppColors.redColor,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: "Rekening",
                            )
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //Keluar
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIn()) {
                            Get.offNamed(RouteHelper.getInitial());
                          } else {
                            Get.toNamed(RouteHelper.getInitial());
                            print("Anda sudah keluar");
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.logout_sharp,
                              backgroundColor: Colors.white.withOpacity(0.0),
                              iconColor: AppColors.redColor,
                              iconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                              text: "Keluar",
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                    ],
                  ),
                ));
      },
    ));
  }
}
