package alternativa.tanks.battle.objects.tank.tankskin {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.materials.TrackMaterial;

  public class SkinMaterials {
    public var hullMaterial:TextureMaterial;
    public var turretMaterial:TextureMaterial;
    public var leftTrackMaterial:TrackMaterial;
    public var rightTrackMaterial:TrackMaterial;

    public function SkinMaterials(param1:TextureMaterial, param2:TextureMaterial, param3:TrackMaterial = null, param4:TrackMaterial = null) {
      super();
      this.hullMaterial = param1;
      this.turretMaterial = param2;
      this.leftTrackMaterial = param3;
      this.rightTrackMaterial = param4;
    }
  }
}
