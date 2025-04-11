package alternativa.tanks.model.payment.modes.terminal {
  import alternativa.tanks.gui.payment.forms.PayModeForm;
  import alternativa.tanks.gui.shop.forms.TerminalForm;
  import alternativa.tanks.model.payment.category.PayModeView;
  import alternativa.tanks.model.payment.modes.CrystalsOnlyPaymentMode;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.payment.modes.terminal.ITerminalPaymentModelBase;
  import projects.tanks.client.panel.model.payment.modes.terminal.TerminalPaymentModelBase;

  [ModelInfo]
  public class TerminalPaymentModel extends TerminalPaymentModelBase implements ITerminalPaymentModelBase, PayModeView, CrystalsOnlyPaymentMode, ObjectLoadListener, ObjectUnloadListener, TerminalPayMode {
    public function TerminalPaymentModel() {
      super();
    }

    public function getView() : PayModeForm {
      return TerminalForm(getData(TerminalForm));
    }

    public function objectLoaded() : void {
      var local1:TerminalForm = new TerminalForm(object,getInitParam());
      putData(TerminalForm,local1);
    }

    public function objectUnloaded() : void {
      this.getView().destroy();
      clearData(TerminalForm);
    }
  }
}
