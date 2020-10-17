
class HomeMenuBean{
  String menuName;
  String menuIcon;

  HomeMenuBean(this.menuName, this.menuIcon);


  Map<String, dynamic> toJson() => {
    'menuName': menuName,
    'menuIcon': menuIcon,
  };

  HomeMenuBean.fromJson(Map<String, dynamic> json) {
    menuName = json['menuName'];
    menuIcon = json['menuIcon'];
  }
}