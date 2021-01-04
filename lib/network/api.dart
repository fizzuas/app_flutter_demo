class Api {
  /// 生成器
  /// debug
  // static const baseUrl = 'http://47.111.177.58:9356/WebServices/WxAppService.svc';
  // static const baseImageUrl2 = 'http://47.111.177.58:9356';
  // release
  static const baseUrl = 'https://www.kydz.online/WebServices/WxAppService.svc';
  static const baseImageUrl = 'http://www.autorke.cn/update/pic/';
  static const baseImageUrl2 = 'https://www.kydz.online';

  // 拷贝机
  /// debug
  // static const copyMachineBaseUrl = 'http://47.111.177.58:9110/WebServices/AppUpdateWebService.svc';
  // release
  static const copyMachineBaseUrl = 'http://www.autorke.cn:9110/WebServices/AppUpdateWebService.svc';

  /// 钥匙机
  static const keyMachineHost = "http://114.215.147.2:9355/";
  static const keyMachineBaseUrl = 'http://114.215.147.2:9355/WebServices/WebService.svc/';
  static const ApkHost = "http://192.168.0.111:9335/";

  static const autorkeBaseUrl ="http://www.autorke.cn:9110/WebServices/AppUpdateWebService.svc";

  static const appUpdateTestHost = "http://47.111.177.58:9110/";
  static const appUpdateHost="http://www.autorke.cn:9110/";

  /// Decrypt QR code
  static const decryptQRCode = '/BarCodeDecrypt';

  /// Sign In
  static const getSmsCode = '/SendSmsCode';
  static const signUp = '/RegisterUser';
  static const modifyPassword = '/SetNewPassword';
  static const signIn = '/Login';
  static const isTokenValid = '/IsTokenValid';

  /// Mall
  static const purchaseProductList = '/FindGoodsForPurchaseShop';
  static const pointsProductList = '/FindGoodsForPointsShop';
  static const purchaseList = '/CreatePurchasingList';
  static const savePointsOrder='/SavePointsOrder';
  static const findUserDeviceListForUser = '/FindUserDeviceListForUser';

  /// 智能卡
  static const findPkeAllAreas = '/FindPkeAllAreas';
  static const findPkeAllBrandsAndRemotes  = '/FindPkeAllBrandsAndRemotes ';
  static const uploadGeneratorPoints  = '/UploadMiniBoxScoreDetailsList ';

  static const specialRemoteData = '/FindSpecialRemoteTypes';
  static const vw5cServiceCode = '/FindCsCode';
  static const submitFeedback = '/SaveFeedbackData';

  static const submitPkeFeedback = '/UploadPkeFeedBack';
  static const pkeFeedbackList = '/FindPkeFeedBack';
  static const userPkeFeedbackRecords = '/FindPkeFeedBackByToken';
  static const togglePKEFeedbackLike = '/LikePkeFeedBack';

  static const submitRkeFeedback = '/UploadNxpFeedBack';
  static const rkeFeedbackList = '/FindNxpFeedBack';
  static const userRkeFeedbackRecords = '/FindNxpFeedBackByToken';
  static const toggleRKEFeedbackLike = '/LikeNxpFeedBack';

  // static const uploadPkeLog = '/UploadBoxPkeLoginfosByFlutter';
  static const uploadPkeLog = '/UploadBoxPkeLoginfosByAndroidCopy';

  /// 地址
  static const saveAddress = '/SaveAddress';
  static const removeAddress = '/DeleteAddress';
  static const addressList = '/FindAddressListForUser';
  static const defaultAddress = '/GetDefaultAddress';

  static const orderList = '/FindPointsOrderListForUser';

  ///小盒子绑定
  static const bindBox = '/AddUserDevice';
  static const unBindBox = '/DeleteUserDevice';

  static const getLogs = '/GetUpdateLog';

  //钥匙机绑定
  static const bindKeyMachine = "/RegisterKeyMachine";
  static const unBindKeyMachine = "/UnRegisterKeyMachine";

  //升级功能
  //主控升级
  static const findLastBleMasterInfo = '/FindLastBleMasterInfo';

  //app升级
  static const findLastBleAppInfo = "/FindFultterAllInOneApp";

  //自定义钥匙功能模块
  static const findSeriesAxisStorateShareInfoList =
      "/FindSeriesAxisStorateShareInfoList";

  //分享自定义钥匙
  static const uploadSeriesAxisStorateShareInfoList =
      "/UploadSeriesAxisStorateShareInfoList";

  static const findAppAdsByFultterAllInOne = '/FindAppAdsByFultterAllInOne';

  ///遥控键值图片上传
  static const UploadPkeImageInfoData = '/UploadPkeReceiveTestUploadImageInfoData';
  static const FileAllPkeImage = '/FindAllPkeReceiveTestUploadImageInfoDatas';

  //keydatabase是否可用
  static const keyDatabaseAvailable = "/FindExchangeVerificationCode";

  //keydatabase验证码是否正确
  static const keyDatabaseCodeCheck = "/UploadBoxIdUploadDataAccessCode";
}