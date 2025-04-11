package alternativa.tanks.gui.payment.forms {
  import alternativa.tanks.model.payment.paymentstate.PaymentWindowService;
  import base.DiscreteSprite;
  import platform.client.fp10.core.type.AutoClosable;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.paymentactions.UserPaymentActionsService;

  public class PayModeForm extends DiscreteSprite implements AutoClosable {
    [Inject]
    public static var userPaymentActionsService:UserPaymentActionsService;

    [Inject]
    public static var paymentWindowService:PaymentWindowService;

    protected var payMode:IGameObject;
    protected var _width:int;
    protected var _height:int;

    public function PayModeForm(param1:IGameObject) {
      super();
      this.payMode = param1;
    }

    public function getPayMode() : IGameObject {
      return this.payMode;
    }

    public function activate() : void {
    }

    protected function logProceedAction() : void {
      userPaymentActionsService.proceed(this.payMode.id,paymentWindowService.getChosenItem().id);
    }

    public function close() : void {
      this.destroy();
    }

    public function destroy() : void {
      this.payMode = null;
    }

    public function isWithoutChosenItem() : Boolean {
      return false;
    }

    public function shouldBeOmitted() : Boolean {
      return false;
    }

    public function getMinHeight() : int {
      return 300;
    }
  }
}
