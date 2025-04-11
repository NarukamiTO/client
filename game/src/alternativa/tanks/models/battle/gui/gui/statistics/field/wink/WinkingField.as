package alternativa.tanks.models.battle.gui.gui.statistics.field.wink {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.IconField;
  import flash.display.DisplayObject;
  import flash.events.Event;

  public class WinkingField extends IconField implements IWinkingField {
    protected var _value:int;
    protected var winkLimit:int;

    private var winkManager:WinkManager;

    public function WinkingField(param1:int, param2:DisplayObject, param3:WinkManager) {
      super(param2);
      this.winkLimit = param1;
      this.winkManager = param3;
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
    }

    public function set value(param1:int) : void {
      this._value = param1;
      this.updateLabel();
      if(this._value <= this.winkLimit) {
        this.startWink();
      } else {
        this.stopWink();
      }
    }

    public function startWink() : void {
      if(this.winkManager != null) {
        this.winkManager.addField(this);
      }
    }

    public function stopWink() : void {
      if(this.winkManager != null) {
        this.winkManager.removeField(this);
      }
      label.visible = true;
    }

    public function setVisible(param1:Boolean) : void {
      label.visible = param1;
    }

    protected function updateLabel() : void {
      text = this._value.toString();
    }

    protected function onRemovedFromStage(param1:Event) : void {
      this.stopWink();
    }
  }
}
