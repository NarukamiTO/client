package alternativa.tanks.models.controlpoints.sfx {
  import alternativa.engine3d.materials.TextureMaterial;

  public class BeamProperties {
    public var beamMaterial:TextureMaterial;
    public var beamTipMaterial:TextureMaterial;
    public var beamWidth:Number;
    public var unitLength:Number;
    public var animationSpeed:Number;
    public var uRange:Number;
    public var alpha:Number;

    public function BeamProperties(param1:TextureMaterial, param2:TextureMaterial, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) {
      super();
      this.beamMaterial = param1;
      this.beamTipMaterial = param2;
      this.beamWidth = param3;
      this.unitLength = param4;
      this.animationSpeed = param5;
      this.uRange = param6;
      this.alpha = param7;
    }
  }
}
