package alternativa.tanks.models.weapon.gauss.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.scene3d.Renderer;

  public class GaussAntennaAimingEffect implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private const FULL_OPENED_ANGLE:Number = -Math.PI / 180 * 60;
    private const FULL_CLOSED_ANGLE:Number = 0;
    private const OPEN_ANTENNA_TIME_MS:Number = 400;
    private const CLOSE_ANTENNA_TIME_MS:Number = 300;
    private const OPEN_SPEED:Number = this.FULL_OPENED_ANGLE / this.OPEN_ANTENNA_TIME_MS;
    private const CLOSE_SPEED:Number = -this.FULL_OPENED_ANGLE / this.CLOSE_ANTENNA_TIME_MS;

    private var antenna:Object3D;
    private var elapsedTime:int;
    private var changeAngleSpeed:Number;
    private var targetAngle:Number;
    private var startingAngle:Number;
    private var openMode:Boolean;

    public function GaussAntennaAimingEffect(param1:Object3D) {
      super();
      this.antenna = param1;
    }

    public function turnOn() : void {
      this.elapsedTime = 0;
      this.openMode = true;
      this.targetAngle = this.FULL_OPENED_ANGLE;
      this.startingAngle = this.antenna.rotationX;
      this.changeAngleSpeed = this.OPEN_SPEED;
      battleService.getBattleScene3D().addRenderer(this);
    }

    public function turnOff() : void {
      this.elapsedTime = 0;
      this.openMode = false;
      this.targetAngle = this.FULL_CLOSED_ANGLE;
      this.startingAngle = this.antenna.rotationX;
      this.changeAngleSpeed = this.CLOSE_SPEED;
      battleService.getBattleScene3D().addRenderer(this);
    }

    public function getRemainingTimeMs() : int {
      return (this.targetAngle - this.startingAngle) / this.changeAngleSpeed;
    }

    public function render(param1:int, param2:int) : void {
      this.elapsedTime += param2;
      this.antenna.rotationX = this.startingAngle + this.elapsedTime * this.changeAngleSpeed;
      if(this.antenna.rotationX < this.FULL_OPENED_ANGLE) {
        this.antenna.rotationX = this.FULL_OPENED_ANGLE;
        this.destroy();
      } else if(this.antenna.rotationX > 0) {
        this.antenna.rotationX = 0;
        this.destroy();
      }
    }

    public function destroy() : void {
      battleService.getBattleScene3D().removeRenderer(this);
    }

    public function reset() : void {
      this.antenna.rotationX = this.FULL_CLOSED_ANGLE;
    }
  }
}
