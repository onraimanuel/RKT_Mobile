import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rumah_kreatif_toba/controllers/produk_controller.dart';
import 'package:rumah_kreatif_toba/models/produk_models.dart';
import 'package:rumah_kreatif_toba/pages/toko/hometoko/hometoko_page.dart';
import 'package:rumah_kreatif_toba/pages/toko/produk/produk_page.dart';
import 'package:rumah_kreatif_toba/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../../base/show_custom_message.dart';
import '../../../controllers/toko_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_dropdown_field_kategori.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';
import '../../../widgets/input_text_field.dart';
import 'dart:io';

class TambahProdukPage extends StatelessWidget {
  const TambahProdukPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var NamaProdukController = TextEditingController();
    var DeskripsiProdukController = TextEditingController();
    var HargaController = TextEditingController();
    var BeratController = TextEditingController();
    var StokController = TextEditingController();
    var KategoriController = TextEditingController();

    Future<void> _tambahProduk() async {
      String namaproduk = NamaProdukController.text.trim();
      String deskripsi = DeskripsiProdukController.text.trim();
      int harga = int.parse(HargaController.text.trim());
      int berat = int.parse(BeratController.text.trim());
      int stok = int.parse(StokController.text.trim());
      String kategori = KategoriController.text.trim();

      if (namaproduk.isEmpty) {
        showCustomSnackBar("Nama produk masih kosong", title: "Nama");
      } else if (deskripsi.isEmpty) {
        showCustomSnackBar("Deskripsi masih kosong", title: "Deskripsi");
      } else if (harga == null) {
        showCustomSnackBar("Harga masih kosong", title: "Harga");
      } else if (stok == null) {
        showCustomSnackBar("Stok masih kosong", title: "Stok");
      } else if (berat == null) {
        showCustomSnackBar("Berat masih kosong", title: "Berat");
      } else if (kategori.isEmpty) {
        showCustomSnackBar("Kategori masih kosong", title: "Kategori");
      } else {
        var userController = Get.find<UserController>();
        await userController.getUser();

        var controller = Get.find<ProdukController>();
        controller
            .tambahProduk(userController.users.id, namaproduk, deskripsi, harga,
                berat, kategori, stok)
            .then((status) async {});
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(HomeTokoPage(initialIndex: 1)); // Pass the initial index to the HomeTokoPage constructor
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: AppColors.redColor,
                    backgroundColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20,
                ),
                Container(
                  child: BigText(
                    text: "Tambah Produk",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          // Nama Produk
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: BigText(
              text: "Nama Produk",
              size: Dimensions.font16,
            ),
          ),
          InputTextField(
            textController: NamaProdukController,
            hintText: 'Nama Produk',
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          //Kategori
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: BigText(
              text: "Kategori",
              size: Dimensions.font16,
            ),
          ),
          AppDropdownFieldKategori(
            hintText: 'Kategori',
            controller: KategoriController,
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          //Deskripsi Produk
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: BigText(
              text: "Deskripsi Produk",
              size: Dimensions.font16,
            ),
          ),
          InputTextField(
            textController: DeskripsiProdukController,
            hintText: 'Deskripsi Produk',
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          //Harga
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: BigText(
              text: "Harga",
              size: Dimensions.font16,
            ),
          ),
          InputTextField(
            textController: HargaController,
            hintText: 'Harga',
            textInputType: TextInputType.number,
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          //Gambar Produk
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: BigText(
              text: "Gambar Produk",
              size: Dimensions.font16,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<ProdukController>(builder: (controller) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.pickImageGambarProduk1();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height20),
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20,
                            bottom: Dimensions.height20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: Icon(
                          Icons.add,
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                    controller.pickedFileGambarProduk1 != null
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(controller
                              .pickedFileGambarProduk1!.path),
                          fit: BoxFit.cover,
                          width: Dimensions.width45*2,
                          height: Dimensions.height45*2,
                        ),
                      ),
                    )
                        : Text(
                      "Tidak Ada Gambar",
                      style: TextStyle(
                          fontSize: Dimensions.font16 / 2),
                    ),
                  ],
                );
              }),
              GetBuilder<ProdukController>(builder: (controller) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.pickImageGambarProduk2();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height20),
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20,
                            bottom: Dimensions.height20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: Icon(
                          Icons.add,
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                    controller.pickedFileGambarProduk2 != null
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(controller
                              .pickedFileGambarProduk2!.path),
                          fit: BoxFit.cover,
                          width: Dimensions.width45*2,
                          height: Dimensions.height45*2,
                        ),
                      ),
                    )
                        : Text(
                      "Tidak Ada Gambar",
                      style: TextStyle(
                          fontSize: Dimensions.font16 / 2),
                    ),
                  ],
                );
              }),
              GetBuilder<ProdukController>(builder: (controller) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.pickImageGambarProduk3();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height20),
                        padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height20,
                            bottom: Dimensions.height20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1, 1),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: Icon(
                          Icons.add,
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                    controller.pickedFileGambarProduk3 != null
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(controller
                              .pickedFileGambarProduk3!.path),
                          fit: BoxFit.cover,
                          width: Dimensions.width45*2,
                          height: Dimensions.height45*2,
                        ),
                      ),
                    )
                        : Text(
                      "Tidak Ada Gambar",
                      style: TextStyle(
                          fontSize: Dimensions.font16 / 2),
                    ),
                  ],
                );
              }),

            ],
          ),

          //Berat
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: BigText(
              text: "Berat",
              size: Dimensions.font16,
            ),
          ),
          InputTextField(
            textController: BeratController,
            hintText: 'Berat',
            textInputType: TextInputType.number,
          ),
          Container(
            child: SmallText(text: "Berat dihitung dalam gram (gr)."),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          //Stok
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: Dimensions.height10),
            child: BigText(
              text: "Harga",
              size: Dimensions.font16,
            ),
          ),
          InputTextField(
            textController: StokController,
            hintText: 'Stok',
            textInputType: TextInputType.number,
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          GestureDetector(
            onTap: () {
              _tambahProduk();
            },
            child: Container(
                width: Dimensions.width45 * 3,
                height: Dimensions.height45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.redColor),
                child: Center(
                  child: BigText(
                    text: "Tambah",
                    size: Dimensions.font20,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    ));
  }
}
