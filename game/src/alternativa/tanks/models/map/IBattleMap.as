package alternativa.tanks.models.map {
  import platform.client.fp10.core.resource.types.SoundResource;
  import projects.tanks.client.battlefield.models.map.DustParams;
  import projects.tanks.client.battlefield.models.map.DynamicShadowParams;
  import projects.tanks.client.battlefield.models.map.FogParams;
  import projects.tanks.client.battlefield.models.map.SkyboxSides;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.clients.flash.resources.resource.MapResource;

  [ModelInterface]
  public interface IBattleMap {
    function getMapResource() : MapResource;
    function getEnvironmentSound() : SoundResource;
    function getSkybox() : SkyboxSides;
    function getGravity() : Number;
    function getSkyboxRevolutionAxis() : Vector3d;
    function getSkyBoxRevolutionSpeed() : Number;
    function getFogParams() : FogParams;
    function getDynamicShadowParams() : DynamicShadowParams;
    function getDustParams() : DustParams;
    function getSSAOColor() : uint;
  }
}
