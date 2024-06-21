





//API Base URL's



// ignore_for_file: constant_identifier_names

const String IP = 'http://stage.tasksplan.com';
//const String IP = 'http://192.168.1.200:8103';
const String VERSION = 'v1/';


// const String BASE_URL = 'https://v5.checkprojectstatus.com/valitag/api/';
const String BASE_URL = 'https://test2.valitag.com.au/';


const String baseImageUrl = 'https://v5.checkprojectstatus.com/valitag/';


String FCM_Token = '12345';
String TIME_ZONE = '';


// APIs url users
const String login = 'login';


const String routeList = 'route/getByUser?ID=';
const String routeDetails = 'route/';
const String getAllAssets= 'asset/all';
String uploadImages(id)=>'/inspection/$id/uploadImage';
String uploadInspection(int routeId,int assetId,String note)=>'route/$routeId/inspection?assetId=$assetId&note=$note';
const String assetsDetails = 'asset/';
const String contactUs = 'contactus';

const String product = 'product';
const String productSave = 'productsave';


// APIs keys
const String authorization = 'Authorization';
const String accept = 'Accept';
const String contentType = 'Content-Type';



// lottie file urls
const String urlClose = 'https://assets2.lottiefiles.com/packages/lf20_DSP8W9Lk91.json';
const String urlPin = 'https://assets2.lottiefiles.com/packages/lf20_XFaiFbfIWF.json';
const String urlDataNotFound = 'https://assets3.lottiefiles.com/packages/lf20_wvaa7s5n.json';

// helper key value
const int NO_PAGE = 0;
const int NO_DATA = 1;
const int DATA = 2;


