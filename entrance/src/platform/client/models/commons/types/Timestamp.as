package platform.client.models.commons.types {
  public class Timestamp {
    private var _day:int;
    private var _hours:int;
    private var _minutes:int;
    private var _month:int;
    private var _seconds:int;
    private var _year:int;

    public function Timestamp(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0) {
      super();
      this._day = param1;
      this._hours = param2;
      this._minutes = param3;
      this._month = param4;
      this._seconds = param5;
      this._year = param6;
    }

    public function get day() : int {
      return this._day;
    }

    public function set day(param1:int) : void {
      this._day = param1;
    }

    public function get hours() : int {
      return this._hours;
    }

    public function set hours(param1:int) : void {
      this._hours = param1;
    }

    public function get minutes() : int {
      return this._minutes;
    }

    public function set minutes(param1:int) : void {
      this._minutes = param1;
    }

    public function get month() : int {
      return this._month;
    }

    public function set month(param1:int) : void {
      this._month = param1;
    }

    public function get seconds() : int {
      return this._seconds;
    }

    public function set seconds(param1:int) : void {
      this._seconds = param1;
    }

    public function get year() : int {
      return this._year;
    }

    public function set year(param1:int) : void {
      this._year = param1;
    }

    public function toString() : String {
      var local1:String = "Timestamp [";
      local1 += "day = " + this.day + " ";
      local1 += "hours = " + this.hours + " ";
      local1 += "minutes = " + this.minutes + " ";
      local1 += "month = " + this.month + " ";
      local1 += "seconds = " + this.seconds + " ";
      local1 += "year = " + this.year + " ";
      return local1 + "]";
    }
  }
}
