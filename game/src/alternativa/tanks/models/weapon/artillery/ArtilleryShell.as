package alternativa.tanks.models.weapon.artillery {
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.loaders.Parser3DS;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtillerySfxData;
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryShellEffects;
  import alternativa.tanks.models.weapons.shell.InelasticShell;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.ArtilleryCC;

  public class ArtilleryShell extends InelasticShell {
    public static var shellMesh:Mesh;

    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    private static const shellClass:Class = ArtilleryShell_shellClass;
    private static const shellTextureClass:Class = ArtilleryShell_shellTextureClass;

    private static var shellTexture:BitmapData = (new shellTextureClass() as Bitmap).bitmapData;

    private var impactForce:Number;
    private var sfxData:ArtillerySfxData;
    private var weaponObject:ArtilleryObject;
    private var material:TextureMaterial;
    private var view:Mesh;
    private var params:ArtilleryCC;
    private var speed:Number;
    private var velocity:Vector3;
    private var prevDirection:Vector3;
    private var interpolatedDirection:Vector3;
    private var elevationAxis:Vector3;
    private var shellEffects:ArtilleryShellEffects;

    public function ArtilleryShell(param1:Pool) {
      var local2:Parser3DS = null;
      this.velocity = new Vector3();
      this.prevDirection = new Vector3();
      this.interpolatedDirection = new Vector3();
      this.elevationAxis = new Vector3();
      super(param1);
      if(shellMesh == null) {
        local2 = new Parser3DS();
        local2.parse(new shellClass());
        shellMesh = Mesh(local2.objects[0]);
        if(shellMesh.sorting != Sorting.DYNAMIC_BSP) {
          shellMesh.sorting = Sorting.DYNAMIC_BSP;
          shellMesh.calculateFacesNormals(true);
          shellMesh.optimizeForDynamicBSP();
        }
      }
      this.view = Mesh(shellMesh.clone());
    }

    public static function moveShell(param1:Number, param2:Vector3, param3:Vector3, param4:Vector3, param5:Vector3, param6:Vector3, param7:Number) : void {
      param3.copy(param2);
      param5.copy(param4);
      var local8:Number = battleService.getBattleRunner().getGravity() * param7;
      param2.addScaled(param1,param6).addScaled(param1 * param1 / 2 * local8,Vector3.Z_AXIS);
      param6.addScaled(local8 * param1,Vector3.Z_AXIS);
      param4.copy(param6).normalize();
    }

    public function init(param1:ArtillerySfxData, param2:ArtilleryObject, param3:ArtilleryCC, param4:Number) : void {
      this.sfxData = param1;
      this.params = param3;
      this.speed = param4;
      this.impactForce = param2.commonData().getImpactForce();
      this.weaponObject = param2;
      this.material = textureMaterialRegistry.getMaterial(shellTexture);
      this.view.setMaterialToAllFaces(this.material);
    }

    override public function addToGame(param1:AllGlobalGunParams, param2:Vector3, param3:Body, param4:Boolean, param5:int) : void {
      super.addToGame(param1,param2,param3,param4,param5);
      this.velocity.copy(param2).scale(this.speed);
      battleService.getBattleScene3D().addObject(this.view);
      this.prevDirection.copy(param2);
      this.elevationAxis.copy(param1.elevationAxis);
      this.shellEffects = new ArtilleryShellEffects(this.view,this.sfxData,this.velocity,param1,param2,this.params.shellGravityCoef);
    }

    override protected function getSpeed() : Number {
      return this.speed;
    }

    override protected function isFlightFinished() : Boolean {
      return super.isFlightFinished() || currPosition.z < battleService.getBattleScene3D().getMapMinZ() - 1000;
    }

    override protected function updatePosition(param1:Number) : void {
      if(this.weaponObject.isAlive()) {
        moveShell(param1,currPosition,prevPosition,flightDirection,this.prevDirection,this.velocity,this.params.shellGravityCoef);
        this.shellEffects.updateShellPosition();
      } else {
        this.destroy();
      }
    }

    override public function interpolatePhysicsState(param1:Number, param2:int) : void {
      super.interpolatePhysicsState(param1,param2);
      this.interpolatedDirection.interpolate(param1,this.prevDirection,flightDirection);
      this.interpolatedDirection.normalize();
    }

    override protected function processHitImpl(param1:Body, param2:Vector3, param3:Vector3, param4:Number, param5:int) : void {
      var local6:Tank = null;
      super.processHitImpl(param1,param2,param3,param4,param5);
      if(this.weaponObject == null) {
        return;
      }
      if(!this.weaponObject.isAlive()) {
        this.destroy();
        return;
      }
      this.weaponObject.splash().applySplashForce(param2,1,param1);
      if(BattleUtils.isTankBody(param1)) {
        local6 = param1.tank;
        local6.applyWeaponHit(param2,param3,this.impactForce);
        this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates,param1.tank);
      } else {
        this.weaponObject.shellCommunication().tryToHit(getShotId(),shellStates);
      }
      this.shellEffects.createExplosionEffect(param2,param3);
      this.destroy();
    }

    override public function render(param1:int, param2:int) : void {
      var local3:Number = param2 / thousandth.getInt();
      this.view.x = interpolatedPosition.x;
      this.view.y = interpolatedPosition.y;
      this.view.z = interpolatedPosition.z;
      var local4:Matrix3 = BattleUtils.tmpMatrix3;
      local4.setAxis(this.elevationAxis,this.interpolatedDirection,BattleUtils.tmpVector.cross2(this.elevationAxis,this.interpolatedDirection).normalize());
      var local5:Vector3 = BattleUtils.tmpVector;
      local4.getEulerAngles(local5);
      this.view.rotationX = local5.x;
      this.view.rotationY = local5.y;
      this.view.rotationZ = local5.z;
      this.shellEffects.updateTrail(local3);
    }

    override protected function destroy() : void {
      super.destroy();
      battleService.getBattleScene3D().removeObject(this.view);
      this.sfxData = null;
      shooterBody = null;
      textureMaterialRegistry.releaseMaterial(this.material);
      this.view.colorTransform = null;
      this.weaponObject = null;
      this.shellEffects.destroy();
      this.shellEffects = null;
    }

    override protected function getRadius() : Number {
      return this.params.shellRadius;
    }
  }
}
