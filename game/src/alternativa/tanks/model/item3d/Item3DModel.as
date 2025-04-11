package alternativa.tanks.model.item3d {
  import alternativa.tanks.service.item.ItemService;
  import alternativa.tanks.service.item3d.ITank3DViewer;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.garage.models.item.item3d.IItem3DModelBase;
  import projects.tanks.client.garage.models.item.item3d.Item3DModelBase;
  import projects.tanks.clients.flash.commons.models.coloring.IColoring;
  import projects.tanks.clients.flash.commons.models.detach.Detach;
  import projects.tanks.clients.flash.resources.object3ds.IObject3DS;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInfo]
  public class Item3DModel extends Item3DModelBase implements IItem3DModelBase, ObjectLoadListener {
    [Inject]
    public static var itemService:ItemService;

    [Inject]
    public static var tank3DViewer:ITank3DViewer;

    public function Item3DModel() {
      super();
    }

    public function objectLoaded() : void {
      var local2:Tanks3DSResource = null;
      var local3:IColoring = null;
      var local1:ItemCategoryEnum = itemService.getCategory(object);
      switch(local1) {
        case ItemCategoryEnum.ARMOR:
          local2 = IObject3DS(object.adapt(IObject3DS)).getResource3DS();
          tank3DViewer.setArmor(local2);
          break;
        case ItemCategoryEnum.WEAPON:
          local2 = IObject3DS(object.adapt(IObject3DS)).getResource3DS();
          tank3DViewer.setWeapon(local2);
          break;
        case ItemCategoryEnum.DRONE:
          local2 = IObject3DS(object.adapt(IObject3DS)).getResource3DS();
          tank3DViewer.setDrone(local2);
          break;
        case ItemCategoryEnum.PAINT:
          local3 = IColoring(object.adapt(IColoring));
          if(local3.isAnimated()) {
            if(getInitParam().mounted) {
              tank3DViewer.setAnimation(local3.getAnimatedColoring());
            } else {
              tank3DViewer.setPreviewAnimation(local3.getAnimatedColoring());
            }
            break;
          }
          if(getInitParam().mounted) {
            tank3DViewer.setColor(local3.getColoring().data);
          } else {
            tank3DViewer.setPreviewColor(local3.getColoring().data);
          }
          break;
      }
      Detach(object.adapt(Detach)).detach();
    }
  }
}
