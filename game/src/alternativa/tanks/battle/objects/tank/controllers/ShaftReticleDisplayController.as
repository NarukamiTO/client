package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.BattleView;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.shaft.ReticleDisplay;

  public class ShaftReticleDisplayController {
    [Inject]
    public static var battleService:BattleService;

    private var camera:GameCamera;
    private var reticleDisplay:ReticleDisplay;

    public function ShaftReticleDisplayController(param1:ReticleDisplay) {
      super();
      this.reticleDisplay = param1;
      this.camera = battleService.getBattleScene3D().getCamera();
    }

    public function update(param1:Vector3) : void {
      var local11:BattleView = null;
      var local2:Number = Number(this.camera.focalLength);
      var local3:Number = Number(this.camera.viewSizeX);
      var local4:Number = Number(this.camera.viewSizeY);
      var local5:Number = Math.atan((local4 + this.reticleDisplay.height / 2) / local2);
      var local6:Number = Math.atan((local3 + this.reticleDisplay.width / 2) / local2);
      var local7:Matrix3 = BattleUtils.tmpMatrix3;
      local7.setRotationMatrixForObject3D(this.camera);
      var local8:Vector3 = BattleUtils.tmpVector;
      local7.transformVectorInverse(param1,local8);
      var local9:Number = Math.atan2(local8.x,local8.z);
      var local10:Number = Math.atan2(local8.y,local8.z);
      this.reticleDisplay.visible = Math.abs(local10) <= local5 && Math.abs(local9) <= local6;
      if(this.reticleDisplay.visible) {
        local11 = battleService.getBattleView();
        this.reticleDisplay.x = local11.getX() + Math.tan(local9) * local2 + local3 - this.reticleDisplay.width / 2;
        this.reticleDisplay.y = local11.getY() + Math.tan(local10) * local2 + local4 - this.reticleDisplay.height / 2;
      }
    }
  }
}
