package alternativa.tanks.models.weapons.shell.states {
  import alternativa.math.Vector3;

  public class DummyShellStates extends ShellStates {
    public static const INSTANCE:DummyShellStates = new DummyShellStates();

    public function DummyShellStates() {
      super(null);
    }

    override public function start(param1:Vector3, param2:Vector3) : void {
    }

    override public function updateState(param1:Vector3, param2:Vector3, param3:int = 666666) : void {
    }

    override public function savePrevPosition() : void {
    }

    override public function destroy() : void {
    }
  }
}
