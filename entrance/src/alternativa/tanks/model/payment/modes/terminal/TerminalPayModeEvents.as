package alternativa.tanks.model.payment.modes.terminal {
  import platform.client.fp10.core.type.IGameObject;

  public class TerminalPayModeEvents implements TerminalPayMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TerminalPayModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
