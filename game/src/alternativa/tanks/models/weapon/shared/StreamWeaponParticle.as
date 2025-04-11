package alternativa.tanks.models.weapon.shared {
  import alternativa.math.Vector3;
  import alternativa.tanks.engine3d.AnimatedSprite3D;
  import alternativa.tanks.models.sfx.colortransform.ColorTransformEntry;
  import flash.geom.ColorTransform;

  public class StreamWeaponParticle extends AnimatedSprite3D {
    private static var INITIAL_POOL_SIZE:int = 20;
    private static var pool:Vector.<StreamWeaponParticle> = new Vector.<StreamWeaponParticle>(INITIAL_POOL_SIZE);
    private static var poolIndex:int = -1;

    public var velocity:Vector3 = new Vector3();
    public var particleDistance:Number = 0;
    public var currFrame:Number;
    public var rotationDirection:int;

    private var animated:Boolean;

    public function StreamWeaponParticle(param1:Boolean) {
      super(100,100);
      softAttenuation = 130;
      colorTransform = new ColorTransform();
      this.animated = param1;
    }

    public static function getParticle(param1:Boolean) : StreamWeaponParticle {
      if(poolIndex == -1) {
        return new StreamWeaponParticle(param1);
      }
      var local2:StreamWeaponParticle = pool[poolIndex];
      local2.animated = param1;
      var local3:* = poolIndex--;
      pool[local3] = null;
      local2.reset();
      return local2;
    }

    private static function interpolateColorTransform(param1:ColorTransformEntry, param2:ColorTransformEntry, param3:Number, param4:ColorTransform) : void {
      param4.alphaMultiplier = param1.alphaMultiplier + param3 * (param2.alphaMultiplier - param1.alphaMultiplier);
      param4.alphaOffset = param1.alphaOffset + param3 * (param2.alphaOffset - param1.alphaOffset);
      param4.redMultiplier = param1.redMultiplier + param3 * (param2.redMultiplier - param1.redMultiplier);
      param4.redOffset = param1.redOffset + param3 * (param2.redOffset - param1.redOffset);
      param4.greenMultiplier = param1.greenMultiplier + param3 * (param2.greenMultiplier - param1.greenMultiplier);
      param4.greenOffset = param1.greenOffset + param3 * (param2.greenOffset - param1.greenOffset);
      param4.blueMultiplier = param1.blueMultiplier + param3 * (param2.blueMultiplier - param1.blueMultiplier);
      param4.blueOffset = param1.blueOffset + param3 * (param2.blueOffset - param1.blueOffset);
    }

    private static function copyStructToColorTransform(param1:ColorTransformEntry, param2:ColorTransform) : void {
      param2.alphaMultiplier = param1.alphaMultiplier;
      param2.alphaOffset = param1.alphaOffset;
      param2.redMultiplier = param1.redMultiplier;
      param2.redOffset = param1.redOffset;
      param2.greenMultiplier = param1.greenMultiplier;
      param2.greenOffset = param1.greenOffset;
      param2.blueMultiplier = param1.blueMultiplier;
      param2.blueOffset = param1.blueOffset;
    }

    override public function setFrameIndex(param1:int) : void {
      if(this.animated) {
        super.setFrameIndex(param1);
      }
    }

    public function reset() : void {
      var local1:ColorTransform = colorTransform;
      local1.redMultiplier = 1;
      local1.greenMultiplier = 1;
      local1.blueMultiplier = 1;
      local1.alphaMultiplier = 1;
      local1.redOffset = 0;
      local1.greenOffset = 0;
      local1.blueOffset = 0;
      local1.alphaOffset = 0;
      alpha = 1;
    }

    public function dispose() : void {
      clear();
      var local1:* = ++poolIndex;
      pool[local1] = this;
    }

    public function updateColorTransform(param1:Number, param2:Vector.<ColorTransformEntry>) : void {
      var local3:Number = NaN;
      var local4:ColorTransformEntry = null;
      var local5:ColorTransformEntry = null;
      var local6:int = 0;
      if(param2 != null) {
        local3 = this.particleDistance / param1;
        if(local3 <= 0) {
          local4 = param2[0];
          copyStructToColorTransform(local4,colorTransform);
        } else if(local3 >= 1) {
          local4 = param2[param2.length - 1];
          copyStructToColorTransform(local4,colorTransform);
        } else {
          local6 = 1;
          local4 = param2[0];
          local5 = param2[1];
          while(local5.t < local3) {
            local6++;
            local4 = local5;
            local5 = param2[local6];
          }
          local3 = (local3 - local4.t) / (local5.t - local4.t);
          interpolateColorTransform(local4,local5,local3,colorTransform);
        }
        alpha = colorTransform.alphaMultiplier;
      }
    }
  }
}
