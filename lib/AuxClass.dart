class AuxClass {
  String convertMonth(numMonth) {
    String month;
    switch (numMonth) {
      case 1:
        month = 'JAN';
        break;
      case 2:
        month = 'FEV';
        break;
      case 3:
        month = 'MAR';
        break;
      case 4:
        month = 'ABR';
        break;
      case 5:
        month = 'MAI';
        break;
      case 6:
        month = 'JUN';
        break;
      case 7:
        month = 'JUL';
        break;
      case 8:
        month = 'AGO';
        break;
      case 9:
        month = 'SET';
        break;
      case 10:
        month = 'OUT';
        break;
      case 11:
        month = 'NOV';
        break;
      case 12:
        month = 'DEZ';
        break;
    }
    return month;
  }

  String convertWeekdDay(numWeekDay) {
    String weekday;
    switch (numWeekDay) {
      case 1:
        weekday = 'Seg';
        break;
      case 2:
        weekday = 'Ter';
        break;
      case 3:
        weekday = 'Qua';
        break;
      case 4:
        weekday = 'Qui';
        break;
      case 5:
        weekday = 'Sex';
        break;
      case 6:
        weekday = 'Sab';
        break;
      case 7:
        weekday = 'Dom';
        break;
    }
    return weekday;
  }
}
