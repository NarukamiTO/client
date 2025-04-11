package alternativa.tanks.model.panel.payment {
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.tanks.gui.panel.ButtonBar;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.payment.IPaymentService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import projects.tanks.client.panel.model.payment.panel.IPaymentButtonModelBase;
  import projects.tanks.client.panel.model.payment.panel.PaymentButtonModelBase;

  [ModelInfo]
  public class PaymentButtonModel extends PaymentButtonModelBase implements IPaymentButtonModelBase, ObjectLoadListener, ObjectLoadPostListener {
    [Inject]
    public static var panelView:IPanelView;

    [Inject]
    public static var paymentService:IPaymentService;

    [Inject]
    public static var launchParams:ILauncherParams;

    public function PaymentButtonModel() {
      super();
    }

    public function objectLoaded() : void {
      paymentService.initPaymentMode(getInitParam());
    }

    public function objectLoadedPost() : void {
      var local1:ButtonBar = panelView.getPanel().buttonBar;
      if(!paymentService.isEnabled() && launchParams.getParameter("shopButtonEnabled","false") != "true") {
        local1.hidePaymentButton();
      }
    }
  }
}
