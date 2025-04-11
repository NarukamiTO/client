package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.engine3d.TextureAnimation;

  public class Smoke extends ParticleSystem {
    private static const MAX_COUNT:int = 5;

    private var size:Number;
    private var speed:Number;
    private var top:Number;
    private var emitterPosition:Vector3 = new Vector3();
    private var animation:TextureAnimation;
    private var container:Scene3DContainer;

    public function Smoke(param1:Number, param2:Number, param3:Number, param4:Number) {
      super(SmokeParticle,param4,MAX_COUNT);
      this.size = param1;
      this.speed = param2;
      this.top = param3;
    }

    public function setAnimation(param1:TextureAnimation) : void {
      this.animation = param1;
    }

    public function setContainer(param1:Scene3DContainer) : void {
      this.container = param1;
    }

    public function setEmitterPosition(param1:Vector3) : void {
      this.emitterPosition.copy(param1);
    }

    override protected function onCreateParticle(param1:Particle) : void {
      var local2:SmokeParticle = SmokeParticle(param1);
      local2.init(this.size,this.emitterPosition,Math.random() * Math.PI * 2,this.animation);
      this.container.addChild(local2.sprite);
    }

    override protected function onUpdateParticle(param1:Particle, param2:Number) : void {
      var local3:SmokeParticle = null;
      local3 = SmokeParticle(param1);
      var local4:AnimatedSprite3D = local3.sprite;
      local4.update(param2);
      local4.z += this.speed * param2;
      var local5:Number = 1 - Math.abs(this.top / 2 - (local4.z - local3.initialZ)) * 2 / this.top;
      local4.alpha = local5;
      local4.rotation = local3.rotation + local5 * 0.3;
      if(local4.z - local3.initialZ >= this.top) {
        local3.alive = false;
      }
    }

    override protected function onDeleteParticle(param1:Particle) : void {
      this.container.removeChild(SmokeParticle(param1).sprite);
    }

    override public function clear() : void {
      super.clear();
      this.animation = null;
      this.container = null;
    }
  }
}
