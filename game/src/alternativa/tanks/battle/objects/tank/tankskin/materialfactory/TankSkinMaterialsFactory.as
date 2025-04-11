package alternativa.tanks.battle.objects.tank.tankskin.materialfactory {
  import alternativa.tanks.battle.objects.tank.tankskin.SkinMaterials;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;

  public interface TankSkinMaterialsFactory {
    function createSkinMaterials(param1:TankSkin, param2:IColoring) : SkinMaterials;
    function createDeadSkinMaterials(param1:TankSkin, param2:TextureResource) : SkinMaterials;
  }
}
