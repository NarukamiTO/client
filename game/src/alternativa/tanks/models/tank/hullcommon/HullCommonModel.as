package alternativa.tanks.models.tank.hullcommon {
  import flash.display.BitmapData;
  import flash.media.Sound;
  import platform.client.fp10.core.resource.types.TextureResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonCC;
  import projects.tanks.client.battlefield.models.tankparts.armor.common.HullCommonModelBase;
  import projects.tanks.client.battlefield.models.tankparts.armor.common.IHullCommonModelBase;

  [ModelInfo]
  public class HullCommonModel extends HullCommonModelBase implements IHullCommonModelBase, HullCommon {
    public function HullCommonModel() {
      super();
    }

    public function getDeadColoring() : TextureResource {
      return getInitParam().deadColoring;
    }

    public function getCC() : HullCommonCC {
      return getInitParam();
    }

    public function getMass() : Number {
      return getInitParam().mass;
    }

    public function setTankObject(param1:IGameObject) : void {
      putData(IGameObject,param1);
    }

    public function getTankObject() : IGameObject {
      return IGameObject(getData(IGameObject));
    }

    public function getStunEffectTexture() : BitmapData {
      return getInitParam().stunEffectTexture.data;
    }

    public function getStunSound() : Sound {
      return getInitParam().stunSound.sound;
    }

    public function getUltimateIconIndex() : int {
      return getInitParam().ultimateIconIndex;
    }
  }
}
