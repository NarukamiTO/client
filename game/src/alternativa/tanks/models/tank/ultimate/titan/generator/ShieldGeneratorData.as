package alternativa.tanks.models.tank.ultimate.titan.generator {
  import alternativa.math.Vector3;
  import alternativa.tanks.models.tank.ultimate.titan.ShieldBeamEffect;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.types.Long;
  import flash.utils.Dictionary;

  public class ShieldGeneratorData {
    public var spherePosition:Vector3;
    public var resources:TitanUltimateResources;
    public var soundEffect:ISound3DEffect;
    public var visualEffect:GraphicEffect;
    public var rotationAngle:Number;

    private var tanksAndBeams:Dictionary = new Dictionary();

    public function ShieldGeneratorData(param1:Vector3, param2:TitanUltimateResources, param3:ISound3DEffect, param4:GraphicEffect, param5:Number) {
      super();
      this.spherePosition = param1;
      this.resources = param2;
      this.soundEffect = param3;
      this.visualEffect = param4;
      this.rotationAngle = param5;
    }

    public function cover(param1:Long) : void {
      this.tanksAndBeams[param1] = true;
    }

    public function addBeam(param1:Long, param2:ShieldBeamEffect) : void {
      this.tanksAndBeams[param1] = param2;
    }

    public function uncover(param1:Long) : void {
      var local2:ShieldBeamEffect = this.tanksAndBeams[param1] as ShieldBeamEffect;
      if(local2 != null) {
        local2.kill();
      }
      delete this.tanksAndBeams[param1];
    }

    public function isTankCovered(param1:Long) : Boolean {
      return this.tanksAndBeams[param1] != null;
    }
  }
}
