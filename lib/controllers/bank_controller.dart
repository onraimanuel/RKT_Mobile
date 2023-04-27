import 'package:rumah_kreatif_toba/controllers/user_controller.dart';
import 'package:rumah_kreatif_toba/data/repository/bank_repo.dart';
import 'package:get/get.dart';
import 'package:rumah_kreatif_toba/models/rekening_model.dart';
import '../base/show_custom_message.dart';
import '../models/response_model.dart';
import '../pages/toko/namatoko.dart';


class BankController extends GetxController{
  final BankRepo bankRepo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BankController({required this.bankRepo});


  Future<ResponseModel> tambahRekening(int? user_id, String nama_bank, String nomor_rekening, String atas_nama) async {
    _isLoading = true;
    update();
    Response response = await bankRepo.tambahRekening(user_id!, nama_bank, nomor_rekening, atas_nama);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      showCustomSnackBar("Berhasil menambah rekening",
          title: "Berhasil");
      Get.to(
            () => NamaToko(),
      );
      getRekeningList();
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  List<dynamic> _daftarRekeningList=[];
  List<dynamic> get daftarRekeningList => _daftarRekeningList;

  Future<void> getRekeningList() async{
    var controller = Get.find<UserController>().usersList[0];
    Response response = await bankRepo.getRekeningList(controller.id!);
    if(response.statusCode == 200){
      List<dynamic> responseBody = response.body;
      _daftarRekeningList = [];
      for (dynamic item in responseBody) {
        Rekening rekening = Rekening.fromJson(item);
        _daftarRekeningList.add(rekening);
      }
      _isLoading = true;
      update();
    }else{

    }
  }

  Future<ResponseModel> hapusRekening(int rekening_id) async {
    _isLoading = true;
    update();
    Response response = await bankRepo.hapusRekening(rekening_id);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      showCustomSnackBar("Produk berhasil dihapus", title: "Berhasil");
      getRekeningList();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

}