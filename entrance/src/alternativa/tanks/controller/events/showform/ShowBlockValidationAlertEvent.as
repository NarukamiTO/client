package alternativa.tanks.controller.events.showform {
  import flash.events.Event;

  public class ShowBlockValidationAlertEvent extends Event {
    public static const YOU_WERE_BLOCKED:String = "ShowBlockValidationAlertEvent.YOU_WERE_BLOCKED";
    public static const YOU_WERE_KICKED:String = "ShowBlockValidationAlertEvent.YOU_WERE_KICKED";

    public var reason:String;
    public var minutes:int;
    public var hours:int;
    public var days:int;

    public function ShowBlockValidationAlertEvent(param1:String, param2:String, param3:int = 0, param4:int = 0, param5:int = 0) {
      super(param1);
      this.reason = param2;
      this.minutes = param3;
      this.hours = param4;
      this.days = param5;
    }

    override public function clone() : Event {
      return new ShowBlockValidationAlertEvent(type,this.reason,this.minutes,this.hours,this.days);
    }
  }
}
