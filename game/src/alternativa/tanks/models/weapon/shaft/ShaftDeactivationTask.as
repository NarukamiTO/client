package alternativa.tanks.models.weapon.shaft {
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.camera.GameCamera;

  public class ShaftDeactivationTask implements Renderer {
    private static const FOV_SPEED:Number = 5 * 0.001;
    private static const ALPHA_SPEED:Number = 5 * 0.001;
    private static const DEFAULT_TARGET_FOV:Number = Math.PI / 2;

    private var battleScene3D:BattleScene3D;
    private var skin:TankSkin;
    private var targetFov:Number;
    private var isRunning:Boolean;

    public function ShaftDeactivationTask(param1:BattleScene3D) {
      super();
      this.battleScene3D = param1;
      this.targetFov = DEFAULT_TARGET_FOV;
    }

    public function setSkin(param1:TankSkin) : void {
      this.skin = param1;
    }

    public function setTargetFov(param1:Number) : void {
      this.targetFov = param1;
    }

    public function start() : void {
      if(!this.isRunning) {
        this.isRunning = true;
        this.battleScene3D.addRenderer(this);
      }
    }

    public function stop() : void {
      if(this.isRunning) {
        this.isRunning = false;
        this.battleScene3D.removeRenderer(this);
      }
    }

    public function render(param1:int, param2:int) : void {
      var local3:GameCamera = this.battleScene3D.getCamera();
      local3.fov += FOV_SPEED * param2;
      if(local3.fov > this.targetFov) {
        local3.fov = this.targetFov;
      }
      var local4:Number = this.skin.getHullAlpha();
      local4 += ALPHA_SPEED * param2;
      if(local4 > 1) {
        local4 = 1;
      }
      this.skin.setAlpha(local4);
      if(local3.fov == this.targetFov && local4 == 1) {
        this.stop();
      }
    }
  }
}
