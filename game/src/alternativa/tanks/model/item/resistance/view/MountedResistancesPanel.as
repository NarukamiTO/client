package alternativa.tanks.model.item.resistance.view {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.shop.components.itemscategory.ItemsCategoryViewGrid;
  import alternativa.tanks.service.resistance.ResistanceService;
  import base.DiscreteSprite;
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import forms.ColorConstants;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class MountedResistancesPanel extends DiscreteSprite {
    [Inject]
    public static var resistanceService:ResistanceService;

    [Inject]
    public static var localeService:ILocaleService;

    private static const VERTICAL_MARGIN:int = 9;
    private static const SLOTS:int = 3;

    private var background:TankWindowInner;
    private var panel:ItemsCategoryViewGrid;
    private var cells:Vector.<ResistanceButton>;
    private var label:LabelBase;

    public function MountedResistancesPanel() {
      var local2:ResistanceButton = null;
      this.background = new TankWindowInner(164,0,TankWindowInner.GREEN);
      this.panel = new ItemsCategoryViewGrid();
      this.cells = new Vector.<ResistanceButton>();
      this.label = new LabelBase();
      super();
      var local1:int = 0;
      while(local1 < SLOTS) {
        local2 = new ResistanceButton(local1);
        this.cells.push(local2);
        this.panel.addItem(local2);
        local1++;
      }
      this.label.text = localeService.getText(TanksLocale.TEXT_GARAGE_CATEGORY_BUTTON_RESISTANCE_MODULES);
      this.label.size = 18;
      this.label.color = ColorConstants.GREEN_TEXT;
      this.label.y += VERTICAL_MARGIN >> 1;
      this.background.addChild(this.label);
      this.panel.y = this.label.y + this.label.height + 4;
      this.panel.horizontalSpacing = 8;
      this.background.addChild(this.panel);
      this.background.height += VERTICAL_MARGIN >> 1;
      addChild(this.background);
      resistanceService.registerView(this);
    }

    public function resize(param1:Number) : void {
      this.render();
      this.background.width = param1;
      if(this.background.height == 0) {
        this.background.height = this.height + VERTICAL_MARGIN;
      }
      this.panel.x = this.background.width - this.panel.width >> 1;
      this.label.x = this.background.width - this.label.width >> 1;
    }

    public function isFull() : Boolean {
      var local1:ResistanceButton = null;
      for each(local1 in this.cells) {
        if(local1.isFree()) {
          return false;
        }
      }
      return true;
    }

    public function getFreeSlot() : int {
      var local1:int = 0;
      while(local1 < SLOTS) {
        if(this.cells[local1].isFree()) {
          return local1;
        }
        local1++;
      }
      return -1;
    }

    private function render() : void {
      if(parent != null) {
        this.panel.render();
      }
    }

    public function getIndex(param1:IGameObject) : int {
      var local2:ResistanceButton = null;
      if(param1 == null) {
        return -1;
      }
      for each(local2 in this.cells) {
        if(local2.item == param1) {
          return local2.getIndex();
        }
      }
      return -1;
    }

    public function setResistInCell(param1:int, param2:IGameObject) : void {
      this.cells[param1].item = param2;
      this.cells[param1].setDeviceImageFromItem(param2);
    }

    public function setAllResist(param1:IGameObject) : void {
      var local2:ResistanceButton = null;
      for each(local2 in this.cells) {
        local2.item = param1;
        local2.setDeviceImageFromItem(param1);
      }
    }

    public function unequipResist(param1:IGameObject) : void {
      var local2:ResistanceButton = null;
      for each(local2 in this.cells) {
        if(param1 == local2.item) {
          local2.reset();
        }
      }
    }

    public function onlyUnmountMode() : * {
      var local1:ResistanceButton = null;
      for each(local1 in this.cells) {
        if(local1.isFree()) {
          local1.disable();
        }
      }
    }

    public function disable() : void {
      var local1:ResistanceButton = null;
      for each(local1 in this.cells) {
        local1.disable();
      }
    }

    public function enable() : void {
      var local1:ResistanceButton = null;
      for each(local1 in this.cells) {
        local1.enable();
      }
    }

    public function destroy() : void {
      resistanceService.unregisterView();
    }
  }
}
