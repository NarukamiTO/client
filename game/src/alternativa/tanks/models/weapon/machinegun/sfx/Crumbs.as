package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.scene3dcontainer.Scene3DContainer;

  public class Crumbs extends ParticleSystem {
    private static const MIN_PARTICLE_SIZE:Number = 130;
    private static const SPEED:Number = 6;
    private static const MAX_TIME:Number = 0.2;
    private static const GRAVITY:Number = 20;
    private static const INTERVAL:int = 0.1;
    private static const MAX_COUNT:int = 5;
    private static const MIN_SCALE:Number = 0.1;
    private static const DIRECTION:Vector3 = new Vector3();

    private var emitterPosition:Vector3 = new Vector3();
    private var material:TextureMaterial;
    private var container:Scene3DContainer;

    public function Crumbs() {
      super(CrumbsParticle,INTERVAL,MAX_COUNT);
    }

    public function setMaterial(param1:TextureMaterial) : void {
      this.material = param1;
    }

    public function setContainer(param1:Scene3DContainer) : void {
      this.container = param1;
    }

    public function setEmitterPosition(param1:Vector3) : void {
      this.emitterPosition.copy(param1);
    }

    override protected function onCreateParticle(param1:Particle) : void {
      var local2:CrumbsParticle = CrumbsParticle(param1);
      var local3:Number = MIN_PARTICLE_SIZE + Math.random() * MIN_PARTICLE_SIZE / 2;
      var local4:Sprite3D = local2.sprite;
      DIRECTION.x = Math.random() * 2 - 1;
      DIRECTION.y = -Math.random();
      DIRECTION.z = Math.random() * 2 - 1;
      DIRECTION.normalize();
      DIRECTION.scale(SPEED);
      local2.init(local3,this.emitterPosition,DIRECTION,this.material);
      this.container.addChild(local4);
    }

    override protected function onUpdateParticle(param1:Particle, param2:Number) : void {
      var local3:CrumbsParticle = CrumbsParticle(param1);
      var local4:Sprite3D = local3.sprite;
      var local5:Vector3 = local3.direction;
      local5.z -= GRAVITY * param2;
      local4.x += local5.x;
      local4.y += local5.y;
      local4.z += local5.z;
      local3.time += param2;
      if(local3.time > MAX_TIME) {
        local3.time = MAX_TIME;
      }
      local4.alpha = 1 - local3.time / MAX_TIME;
      var local6:Number = 1 - local4.alpha;
      if(local6 < MIN_SCALE) {
        local6 = MIN_SCALE;
      }
      local4.scaleX = local6;
      local4.scaleY = local6;
      local4.scaleZ = local6;
      if(local4.alpha <= 0) {
        local3.alive = false;
      }
    }

    override protected function onDeleteParticle(param1:Particle) : void {
      this.container.removeChild(CrumbsParticle(param1).sprite);
    }

    override public function clear() : void {
      super.clear();
      this.material = null;
      this.container = null;
    }
  }
}
