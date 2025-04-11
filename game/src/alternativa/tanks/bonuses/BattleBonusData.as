package alternativa.tanks.bonuses {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import flash.media.Sound;

  public class BattleBonusData {
    public var boxMesh:Mesh;
    public var parachuteOuterMesh:Mesh;
    public var parachuteInnerMesh:Mesh;
    public var cordsMaterial:TextureMaterial;
    public var pickupSound:Sound;
    public var lightColor:uint;
    public var lightIntensity:Number;
    public var attenuationBegin:Number;
    public var attenuationEnd:Number;

    public function BattleBonusData() {
      super();
    }
  }
}
