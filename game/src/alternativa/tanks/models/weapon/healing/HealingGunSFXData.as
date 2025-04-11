package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.sfx.LightAnimation;
  import flash.media.Sound;

  public class HealingGunSFXData {
    public var idleMuzzle:TextureAnimation;
    public var idleSound:Sound;
    public var healMuzzle:TextureAnimation;
    public var healTarget:TextureAnimation;

    private var _healShaft:TextureMaterial;

    public var healSound:Sound;
    public var damageMuzzle:TextureAnimation;
    public var damageTarget:TextureAnimation;

    private var _damageShaft:TextureMaterial;

    public var damageSound:Sound;
    public var startLightAnimation:LightAnimation;
    public var loopLightAnimation:LightAnimation;
    public var friendStartLightAnimation:LightAnimation;
    public var friendLoopLightAnimation:LightAnimation;
    public var enemyStartLightAnimation:LightAnimation;
    public var enemyLoopLightAnimation:LightAnimation;
    public var friendBeamAnimation:LightAnimation;
    public var enemyBeamAnimation:LightAnimation;

    public function HealingGunSFXData() {
      super();
    }

    public function set healShaft(param1:TextureMaterial) : void {
      this._healShaft = param1;
    }

    public function set damageShaft(param1:TextureMaterial) : void {
      this._damageShaft = param1;
    }

    public function getHealShaft() : TextureMaterial {
      return this._healShaft;
    }

    public function getDamageShaft() : TextureMaterial {
      return this._damageShaft;
    }

    public function getMaterialsToRelease() : Array {
      return [this.idleMuzzle.material,this.healMuzzle.material,this._healShaft,this.damageMuzzle.material,this._damageShaft];
    }
  }
}
