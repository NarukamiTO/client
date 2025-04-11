package alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.aim {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.ClientTankState;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.scene3d.Renderer;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.rocketlauncher.weapon.salvo.RocketTargetPoint;
  import flash.display.BitmapData;

  public class RocketLauncherAim implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private static const position:Vector3 = new Vector3();

    private var visible:Boolean;
    private var spriteAim:Sprite3D;
    private var target:RocketTargetPoint;
    private var aimShape:AimShape;
    private var soundEffect:AimSoundEffect;
    private var weaponStatus:AimWeaponStatus;
    private var targetWasLost:Boolean;

    public function RocketLauncherAim(param1:RocketTargetPoint, param2:AimWeaponStatus, param3:AimSoundEffect) {
      super();
      this.target = param1;
      this.soundEffect = param3;
      this.weaponStatus = param2;
      this.aimShape = new AimShape();
      var local4:BitmapData = new BitmapData(this.aimShape.width,this.aimShape.height,true,0);
      this.aimShape.setTexture(local4);
      var local5:TextureMaterial = new TextureMaterial(local4);
      local5.uploadEveryFrame = true;
      this.spriteAim = new Sprite3D(this.aimShape.width,this.aimShape.height,local5);
      this.spriteAim.perspectiveScale = false;
      this.spriteAim.useShadowMap = false;
      this.spriteAim.useLight = false;
      this.spriteAim.depthTest = false;
    }

    public function show() : void {
      if(!this.visible) {
        battleService.getBattleScene3D().getFrontContainer().addChild(this.spriteAim);
        battleService.getBattleScene3D().addRenderer(this,0);
        this.visible = true;
        this.targetWasLost = false;
        this.soundEffect.playAimingSoundEffect();
      }
    }

    public function hide() : void {
      if(this.visible) {
        battleService.getBattleScene3D().getFrontContainer().removeChild(this.spriteAim);
        battleService.getBattleScene3D().removeRenderer(this,0);
        this.visible = false;
        this.soundEffect.killAimingSoundEffect();
      }
    }

    public function render(param1:int, param2:int) : void {
      var local4:GameCamera = null;
      var local5:Vector3 = null;
      var local6:Vector3 = null;
      var local3:Tank = this.target.getTank();
      if(this.target.hasTarget() && local3.state == ClientTankState.ACTIVE) {
        this.actualizeEffects();
        local4 = battleService.getBattleScene3D().getCamera();
        local5 = local4.position;
        local6 = local3.interpolatedPosition;
        if(local4.fogNear > 0) {
          position.diff(local6,local5).setLength(local4.fogNear * 0.5).add(local5);
        } else {
          position.copy(local6);
        }
        this.spriteAim.x = position.x;
        this.spriteAim.y = position.y;
        this.spriteAim.z = position.z;
        this.targetWasLost = this.target.isLost();
      } else {
        this.hide();
      }
    }

    private function actualizeEffects() : void {
      this.aimShape.update(this.target.isLost(),1 - this.weaponStatus.getStatus());
      if(this.targetWasLost != this.target.isLost()) {
        if(this.target.isLost()) {
          this.soundEffect.playTargetLostSoundEffect();
        } else {
          this.soundEffect.playAimingSoundEffect();
        }
      }
    }
  }
}
