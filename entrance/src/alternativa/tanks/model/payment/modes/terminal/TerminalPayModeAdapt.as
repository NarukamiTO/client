package alternativa.tanks.model.payment.modes.terminal {
  import platform.client.fp10.core.type.IGameObject;

  public class TerminalPayModeAdapt implements TerminalPayMode {
    private var object:IGameObject;
    private var impl:TerminalPayMode;

    public function TerminalPayModeAdapt(param1:IGameObject, param2:TerminalPayMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
