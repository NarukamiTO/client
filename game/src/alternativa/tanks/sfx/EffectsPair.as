package alternativa.tanks.sfx {
  public class EffectsPair {
    public var graphicEffect:GraphicEffect;
    public var soundEffect:ISound3DEffect;

    public function EffectsPair(param1:GraphicEffect, param2:ISound3DEffect) {
      super();
      this.graphicEffect = param1;
      this.soundEffect = param2;
    }
  }
}
