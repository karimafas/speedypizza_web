library speedypizza_web.globals;

int orderNumber;
int reopenedOrderNumber;

//Current customer data
String name;
String surname;
String phone;
String address;
String doorno;
String floor;
String discount;
String credit;
String notes = "";
String area;

void clear() {
  name = "";
  surname = "";
  phone = "";
  address = "";
  doorno = "";
  floor = "";
  discount = "";
  credit = "";
  notes = "";
  area = "";
}

//Screens data
int selectedScreen = 0;

//Reopened orders data
String datePlaced = "";
String timePlaced = "";
bool hasOpenedFirstOrder = false;

//Today data
List todaysList = [];