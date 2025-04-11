package alternativa.tanks.sfx {
  import alternativa.engine3d.core.Object3D;
  import alternativa.tanks.camera.GameCamera;
  import alternativa.tanks.models.weapon.shared.StreamWeaponParticle;
  import alternativa.tanks.models.weapon.streamweapon.StreamWeaponGraphicEffect;
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class StreamWeaponParticlesPositionProvider extends PooledObject implements Object3DPositionProvider {
    private var _streamWeaponGraphicEffect:StreamWeaponGraphicEffect;
    private var _defaultPositionProvider:CollisionObject3DPositionProvider;
    private var weightDistance:Array = [0.1,0.3,0.5,0.8,0.9,1];
    private var weightValue:Array = [0.5,0.8,1,0.5,0.3,0.05];

    public function StreamWeaponParticlesPositionProvider(param1:Pool) {
      super(param1);
    }

    public function init(param1:StreamWeaponGraphicEffect, param2:CollisionObject3DPositionProvider) : void {
      this._streamWeaponGraphicEffect = param1;
      this._defaultPositionProvider = param2;
    }

    public function initPosition(param1:Object3D) : void {
      var local6:Vector.<StreamWeaponParticle> = null;
      var local7:int = 0;
      var local8:StreamWeaponParticle = null;
      var local9:Number = NaN;
      var local10:Number = NaN;
      var local2:Number = 0;
      var local3:Number = 0;
      var local4:Number = 0;
      var local5:Number = 0;
      if(this._streamWeaponGraphicEffect.numParticles == 0) {
        this._defaultPositionProvider.initPosition(param1);
      } else {
        local6 = this._streamWeaponGraphicEffect.particles;
        local7 = 0;
        while(local7 < this._streamWeaponGraphicEffect.numParticles) {
          local8 = local6[local7];
          local9 = local8.particleDistance / this._streamWeaponGraphicEffect.range;
          local10 = this.getWeight(local9);
          local5 += local10;
          local2 += local8.x * local10;
          local3 += local8.y * local10;
          local4 += local8.z * local10;
          local7++;
        }
        local2 /= local5;
        local3 /= local5;
        local4 /= local5;
        param1.x = local2;
        param1.y = local3;
        param1.z = local4;
      }
    }

    private function getWeight(param1:Number) : Number {
      var local3:Number = NaN;
      var local2:int = 0;
      while(local2 < this.weightDistance.length) {
        local3 = Number(this.weightDistance[local2]);
        if(local3 >= param1) {
          return this.weightValue[local2];
        }
        local2++;
      }
      return 0;
    }

    public function updateObjectPosition(param1:Object3D, param2:GameCamera, param3:int) : void {
      this.initPosition(param1);
    }

    public function destroy() : void {
      this._streamWeaponGraphicEffect = null;
      this._defaultPositionProvider = null;
    }
  }
}
