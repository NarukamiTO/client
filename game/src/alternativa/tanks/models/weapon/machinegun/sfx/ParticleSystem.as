package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.tanks.battle.BattleService;
  import flash.utils.Dictionary;

  public class ParticleSystem {
    [Inject]
    public static var battleService:BattleService;

    private var particles:Dictionary = new Dictionary();
    private var particleClass:Class;
    private var emit:Boolean;
    private var emitInterval:Number = 0;
    private var time:Number = 0;
    private var count:int;
    private var maxCount:int;

    public function ParticleSystem(param1:Class, param2:Number, param3:int) {
      super();
      this.particleClass = param1;
      this.emitInterval = param2;
      this.maxCount = param3;
    }

    public function start() : void {
      this.emit = true;
    }

    public function stop() : void {
      this.emit = false;
    }

    public function update(param1:Number) : Boolean {
      var local2:* = undefined;
      var local3:Particle = null;
      if(this.emit) {
        this.time += param1;
        if(this.time >= this.emitInterval) {
          this.time = 0;
          if(this.count < this.maxCount) {
            this.createParticle();
          }
        }
      }
      for(local2 in this.particles) {
        local3 = local2;
        this.onUpdateParticle(local3,param1);
        if(!local3.alive) {
          this.deleteParticle(local3);
        }
      }
      return this.emit || this.count > 0;
    }

    public function clear() : void {
      var local1:* = undefined;
      var local2:Particle = null;
      for(local1 in this.particles) {
        local2 = local1;
        this.deleteParticle(local2);
      }
      this.stop();
    }

    protected function onCreateParticle(param1:Particle) : void {
    }

    protected function onUpdateParticle(param1:Particle, param2:Number) : void {
    }

    protected function onDeleteParticle(param1:Particle) : void {
    }

    private function createParticle() : void {
      var local1:Particle = Particle(battleService.getObjectPool().getObject(this.particleClass));
      local1.alive = true;
      this.onCreateParticle(local1);
      this.particles[local1] = true;
      ++this.count;
    }

    private function deleteParticle(param1:Particle) : void {
      this.onDeleteParticle(param1);
      delete this.particles[param1];
      param1.recycle();
      --this.count;
    }
  }
}
