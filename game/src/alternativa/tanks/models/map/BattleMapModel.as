package alternativa.tanks.models.map {
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.map.BattleMapModelBase;
  import projects.tanks.client.battlefield.models.map.DustParams;
  import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
  import projects.tanks.client.battlefield.models.map.FogParams;
  import projects.tanks.client.battlefield.models.map.IBattleMapModelBase;
  import projects.tanks.client.battlefield.models.map.SkyboxSides;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.MapResource;

  [ModelInfo]
  public class BattleMapModel extends BattleMapModelBase implements IBattleMapModelBase, IBattleMap {
    public function BattleMapModel() {
      super();
    }

    public function getMapResource() : MapResource {
      return getInitParam().mapResource;
    }

    public function getEnvironmentSound() : SoundResource {
      return getInitParam().environmentSound;
    }

    public function getSkybox() : SkyboxSides {
      return getInitParam().skyboxSides;
    }

    public function getGravity() : Number {
      return getInitParam().gravity;
    }

    public function getSkyboxRevolutionAxis() : Vector3d {
      return getInitParam().skyBoxRevolutionAxis;
    }

    public function getSkyBoxRevolutionSpeed() : Number {
      return getInitParam().skyBoxRevolutionSpeed;
    }

    public function getFogParams() : FogParams {
      return getInitParam().fogParams;
    }

    public function getDynamicShadowParams() : DynamicShadowParams {
      return getInitParam().dynamicShadowParams;
    }

    public function getDustParams() : DustParams {
      return getInitParam().dustParams;
    }

    public function getSSAOColor() : uint {
      return getInitParam().ssaoColor;
    }
  }
}
