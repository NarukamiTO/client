package alternativa.engine3d.core {
  public class ShadowMap {
    public var mapSize:int;
    public var nearDistance:Number;
    public var farDistance:Number;
    public var bias:Number = 0;
    public var additionalSpace:Number = 0;
    public var alphaThreshold:Number = 0.1;

    public function ShadowMap(param1:int, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0) {
      super();
      this.mapSize = param1;
      this.nearDistance = param2;
      this.farDistance = param3;
      this.bias = param4;
      this.additionalSpace = param5;
    }

    public function dispose() : void {
    }
  }
}
