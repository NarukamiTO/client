package alternativa.tanks.models.weapon.terminator.sfx {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.sfx.ITerminatorSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.terminator.sfx.TerminatorSFXModelBase;

  [ModelInfo]
  public class TerminatorSFXModel extends TerminatorSFXModelBase implements ITerminatorSFXModelBase, TerminatorSFX, ObjectLoadListener {
    public function TerminatorSFXModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:TerminatorSFXData = new TerminatorSFXData(getInitParam());
      putData(TerminatorSFXData,local1);
    }

    public function getSfxData() : TerminatorSFXData {
      return TerminatorSFXData(getData(TerminatorSFXData));
    }
  }
}
