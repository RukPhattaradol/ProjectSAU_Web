class iotvaluehistory {
  String? idIot;
  double? humValue;
  double? tempValue;
  double? ultraValue;
  String? date;
  String? time;
  String? dateStart;
  String? dateEnd;
  String? valueText;

  iotvaluehistory({
    this.idIot,
    this.humValue,
    this.tempValue,
    this.ultraValue,
    this.date,
    this.time,
    this.dateStart,
    this.dateEnd,
    this.valueText,
  });

  iotvaluehistory.fromJson(Map<String, dynamic> json) {
    idIot = json['idIot'];
    humValue = json['humValue'];
    tempValue = json['tempValue'];
    ultraValue = json['ultraValue'];
    date = json['date'];
    time = json['time'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    valueText = json['valueText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idIot'] = this.idIot;
    data['humValue'] = this.humValue;
    data['tempValue'] = this.tempValue;
    data['ultraValue'] = this.ultraValue;
    data['date'] = this.date;
    data['time'] = this.time;
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['valueText'] = this.valueText;
    return data;
  }
}
