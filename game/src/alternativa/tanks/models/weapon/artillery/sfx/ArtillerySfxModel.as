package alternativa.tanks.models.weapon.artillery.sfx {
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx.ArtillerySfxModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.artillery.sfx.IArtillerySfxModelBase;

  [ModelInfo]
  public class ArtillerySfxModel extends ArtillerySfxModelBase implements IArtillerySfxModelBase, ObjectLoadListener, ArtillerySfx {
    public function ArtillerySfxModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:ArtillerySfxData = new ArtillerySfxData(object,getInitParam(),new LightingSfx(getInitParam().lightingSFXEntity));
      putData(ArtillerySfxData,local1);
    }

    public function getSfxData() : ArtillerySfxData {
      return ArtillerySfxData(getData(ArtillerySfxData));
    }
  }
}
