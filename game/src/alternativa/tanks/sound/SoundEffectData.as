package alternativa.tanks.sound {
  import alternativa.tanks.sfx.ISound3DEffect;

  internal class SoundEffectData {
    private static var numObjects:int;
    private static var pool:Vector.<SoundEffectData> = new Vector.<SoundEffectData>();

    public var distanceSqr:Number;
    public var effect:ISound3DEffect;

    public function SoundEffectData(param1:Number, param2:ISound3DEffect) {
      super();
      this.distanceSqr = param1;
      this.effect = param2;
    }

    public static function create(param1:Number, param2:ISound3DEffect) : SoundEffectData {
      var local3:SoundEffectData = null;
      if(numObjects > 0) {
        local3 = pool[--numObjects];
        pool[numObjects] = null;
        local3.distanceSqr = param1;
        local3.effect = param2;
        return local3;
      }
      return new SoundEffectData(param1,param2);
    }

    public static function destroy(param1:SoundEffectData) : void {
      param1.effect = null;
      var local2:* = numObjects++;
      pool[local2] = param1;
    }
  }
}
