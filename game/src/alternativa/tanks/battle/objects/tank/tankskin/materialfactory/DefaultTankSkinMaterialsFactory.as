package alternativa.tanks.battle.objects.tank.tankskin.materialfactory {
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.skintexturesregistry.TankSkinTextureRegistry;
  import alternativa.tanks.battle.objects.tank.tankskin.SkinMaterials;
  import alternativa.tanks.battle.objects.tank.tankskin.TankHullSkinCacheItem;
  import alternativa.tanks.battle.objects.tank.tankskin.TankSkin;
  import alternativa.tanks.battle.objects.tank.tankskin.turret.TurretSkinCacheItem;
  import alternativa.tanks.materials.TrackMaterial;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;

  public class DefaultTankSkinMaterialsFactory implements TankSkinMaterialsFactory {
    [Inject]
    public static var textureMaterialRegistry:TextureMaterialRegistry;

    [Inject]
    public static var skinTextureRegistry:TankSkinTextureRegistry;

    [Inject]
    public static var battleService:BattleService;

    public function DefaultTankSkinMaterialsFactory() {
      super();
    }

    public function createSkinMaterials(param1:TankSkin, param2:IColoring) : SkinMaterials {
      var local13:MultiframeTextureResource = null;
      var local14:TextureMaterial = null;
      var local15:TextureMaterial = null;
      var local16:TextureResource = null;
      var local3:TankHullSkinCacheItem = param1.getHullDescriptor();
      var local4:TurretSkinCacheItem = param1.getTurretDescriptor();
      var local5:Long = local3.partId;
      var local6:BitmapData = local3.lightmap;
      var local7:BitmapData = local3.details;
      var local8:Long = local4.partId;
      var local9:BitmapData = local4.lightmap;
      var local10:BitmapData = local4.details;
      if(param2.isAnimated()) {
        local13 = param2.getAnimatedColoring();
        local14 = textureMaterialRegistry.getAnimatedPaint(local13,local6,local7,local5);
        local15 = textureMaterialRegistry.getAnimatedPaint(local13,local9,local10,local8);
      } else {
        local16 = param2.getColoring();
        local14 = textureMaterialRegistry.getPaint(local16,local6,local7,local5);
        local15 = textureMaterialRegistry.getPaint(local16,local9,local10,local8);
      }
      var local11:TrackMaterial = new TrackMaterial(local7);
      var local12:TrackMaterial = new TrackMaterial(local7);
      textureMaterialRegistry.addMaterial(local11);
      textureMaterialRegistry.addMaterial(local12);
      return new SkinMaterials(local14,local15,local11,local12);
    }

    public function createDeadSkinMaterials(param1:TankSkin, param2:TextureResource) : SkinMaterials {
      var local3:TankHullSkinCacheItem = param1.getHullDescriptor();
      var local4:TurretSkinCacheItem = param1.getTurretDescriptor();
      var local5:Long = local3.partId;
      var local6:BitmapData = local3.lightmap;
      var local7:BitmapData = local3.details;
      var local8:Long = local4.partId;
      var local9:BitmapData = local4.lightmap;
      var local10:BitmapData = local4.details;
      var local11:TextureMaterial = textureMaterialRegistry.getPaint(param2,local6,local7,local5);
      var local12:TextureMaterial = textureMaterialRegistry.getPaint(param2,local9,local10,local8);
      return new SkinMaterials(local11,local12);
    }
  }
}
