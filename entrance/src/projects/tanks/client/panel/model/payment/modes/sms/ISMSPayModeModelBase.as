package projects.tanks.client.panel.model.payment.modes.sms {
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSNumber;
  import projects.tanks.client.panel.model.payment.modes.sms.types.SMSOperator;

  public interface ISMSPayModeModelBase {
    function setNumbers(param1:Vector.<SMSNumber>) : void;
    function setOperators(param1:Vector.<SMSOperator>) : void;
  }
}
