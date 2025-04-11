package alternativa.tanks.model.payment.modes.qiwi {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.qiwi.CountryPhoneInfo;

  public class QiwiPaymentAdapt implements QiwiPayment {
    private var object:IGameObject;
    private var impl:QiwiPayment;

    public function QiwiPaymentAdapt(param1:IGameObject, param2:QiwiPayment) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPaymentUrlAsync(param1:String) : void {
      var phone:String = param1;
      try {
        Model.object = this.object;
        this.impl.getPaymentUrlAsync(phone);
      }
      finally {
        Model.popObject();
      }
    }

    public function getCountryPhoneInfo() : Vector.<CountryPhoneInfo> {
      var result:Vector.<CountryPhoneInfo> = null;
      try {
        Model.object = this.object;
        result = this.impl.getCountryPhoneInfo();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
