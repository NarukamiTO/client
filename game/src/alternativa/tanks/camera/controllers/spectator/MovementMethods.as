package alternativa.tanks.camera.controllers.spectator {
  public class MovementMethods {
    private var methods:Vector.<MovementMethod>;
    private var currentMethodIndex:int;

    public function MovementMethods(param1:Vector.<MovementMethod>) {
      super();
      this.methods = param1;
    }

    public function getMethod() : MovementMethod {
      return this.methods[this.currentMethodIndex];
    }

    public function selectNextMethod() : void {
      this.currentMethodIndex = (this.currentMethodIndex + 1) % this.methods.length;
    }
  }
}
