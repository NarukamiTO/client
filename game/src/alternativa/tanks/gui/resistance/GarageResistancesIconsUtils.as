package alternativa.tanks.gui.resistance {
  import alternativa.tanks.model.garage.resistance.ModuleResistances;
  import alternativa.tanks.model.garage.resistance.ResistancesIconsUtils;
  import flash.display.Bitmap;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public class GarageResistancesIconsUtils {
    public function GarageResistancesIconsUtils() {
      super();
    }

    public static function addIconsToParent(param1:Bitmap, param2:IGameObject) : void {
      if(!param2.hasModel(ModuleResistances)) {
        return;
      }
      var local3:Vector.<ItemGarageProperty> = ModuleResistances(param2.adapt(ModuleResistances)).getResistances();
      ResistancesIconsUtils.addResistanceIcons(param1,local3);
    }
  }
}
