class CourseModel {
  String name;
  String description;
  String university;
  String noOfCource;
  String tag1;

  CourseModel(
      {this.name,
      this.description,
      this.noOfCource,
      this.university,
      this.tag1,});
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        name: "Visite ",
        description: "description de visite "+DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString(),
        university: "Docteur Mohamed Haded",
        noOfCource: "",
        tag1: "H",),
    CourseModel(
        name: "Visite ",
        description: "description de visite "+DateTime.now().day.toString()+"/"+DateTime.now().month.toString()+"/"+DateTime.now().year.toString(),
        university: "Docteur Mohamed Haded",
        noOfCource: "",
        tag1: "H",)
  ];
}
