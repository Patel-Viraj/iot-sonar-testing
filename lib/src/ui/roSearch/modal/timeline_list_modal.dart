class TimelineModal {
  String? time;
  String? title;
  String? hours;
  String? name;
  bool? isShowImage;
  bool? isInProgress;

  TimelineModal(
      {this.title,
      this.time,
      this.hours,
      this.name,
      this.isShowImage = false,
      this.isInProgress = false});
}
