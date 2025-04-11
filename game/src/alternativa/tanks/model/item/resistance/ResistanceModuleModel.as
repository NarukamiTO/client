package alternativa.tanks.model.item.resistance {
  import alternativa.tanks.model.garage.resistance.ModuleResistances;
  import alternativa.tanks.model.item.info.ItemActionPanel;
  import alternativa.tanks.model.item.properties.ItemPropertyValue;
  import alternativa.tanks.model.item.resistance.view.ResistancePanel;
  import alternativa.tanks.service.item.ItemService;
  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;
  import projects.tanks.client.commons.types.ItemGarageProperty;
  import projects.tanks.client.garage.models.item.resistance.IResistanceModuleModelBase;
  import projects.tanks.client.garage.models.item.resistance.ResistanceModuleModelBase;

  [ModelInfo]
  public class ResistanceModuleModel extends ResistanceModuleModelBase implements IResistanceModuleModelBase, ModuleResistances, ItemActionPanel {
    [Inject]
    public static var itemService:ItemService;

    private var actionPanel:ResistancePanel;

    public function ResistanceModuleModel() {
      super();
    }

    public function getPanel() : ResistancePanel {
      if(this.actionPanel == null) {
        this.actionPanel = new ResistancePanel();
      }
      return this.actionPanel;
    }

    public function getResistances() : Vector.<ItemGarageProperty> {
      var local1:Vector.<ItemPropertyValue> = itemService.getProperties(object);
      var local2:Vector.<ItemGarageProperty> = new Vector.<ItemGarageProperty>(local1.length);
      var local3:int = 0;
      while(local3 < local1.length) {
        local2[local3] = local1[local3].getProperty();
        local3++;
      }
      return local2;
    }

    public function handleDoubleClickOnItemPreview() : void {
      this.getPanel().onDoubleClick();
    }

    public function updateActionElements(param1:DisplayObjectContainer, param2:IEventDispatcher) : void {
      this.getPanel().updateActionElements(param1,param2,object);
    }
  }
}
