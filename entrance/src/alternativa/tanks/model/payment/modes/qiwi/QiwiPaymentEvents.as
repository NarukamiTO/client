package alternativa.tanks.model.payment.modes.qiwi {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.qiwi.CountryPhoneInfo;

  public class QiwiPaymentEvents implements QiwiPayment {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function QiwiPaymentEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPaymentUrlAsync(param1:String) : void {
      var i:int = 0;
      var m:QiwiPayment = null;
      var phone:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = QiwiPayment(this.impl[i]);
          m.getPaymentUrlAsync(phone);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getCountryPhoneInfo() : Vector.<CountryPhoneInfo> {
      var result:Vector.<CountryPhoneInfo> = null;
      var i:int = 0;
      var m:QiwiPayment = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = QiwiPayment(this.impl[i]);
          result = m.getCountryPhoneInfo();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
