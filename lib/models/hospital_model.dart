class Place {
  String name;
  String address;
  String placeId;



  Place({this.name,this.address, this.placeId,});
  @override
  String toString() {
    return 'Hospital: {name: ${name}, adress: ${address}, id: ${placeId}';
  }

  Place.fromJson(Map<String,dynamic> json){
    name = json['name'];
    address = json['vicinity'];
    placeId = json['place_id'];

  }
}