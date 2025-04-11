package alternativa.tanks.models.battle.battlefield.mine {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.osgi.service.console.variables.ConsoleVarInt;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.camera.ICameraStateModifier;
  import alternativa.tanks.camera.IFollowCameraController;

  public class MineExplosionCameraEffect implements ICameraStateModifier {
    private static var amplitude:ConsoleVarFloat;
    private static var yawAmplitude:ConsoleVarFloat;
    private static var rollAmplitude:ConsoleVarFloat;
    private static var duration:ConsoleVarInt;
    private static var m1:Matrix3 = new Matrix3();
    private static var m2:Matrix3 = new Matrix3();
    private static var axis:Vector3 = new Vector3();

    private var sign:int;
    private var time:int;
    private var tank:Tank;

    public function MineExplosionCameraEffect() {
      super();
    }

    public static function initVars() : void {
      amplitude = new ConsoleVarFloat("minecam_ampl",0,-10000,10000);
      yawAmplitude = new ConsoleVarFloat("minecam_yaw",-0.02,-10,10);
      rollAmplitude = new ConsoleVarFloat("minecam_roll",0.03,-10,10);
      duration = new ConsoleVarInt("minecam_time",800,0,10000);
    }

    public function update(param1:int, param2:int, param3:Vector3, param4:Vector3) : Boolean {
      if(param1 - this.time > duration.value) {
        return false;
      }
      return true;
    }

    public function onAddedToController(param1:IFollowCameraController) : void {
    }

    public function destroy() : void {
    }
  }
}
