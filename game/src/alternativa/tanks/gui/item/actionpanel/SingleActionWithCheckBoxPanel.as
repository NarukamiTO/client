package alternativa.tanks.gui.item.actionpanel {
  import controls.checkbox.CheckBoxBase;
  import controls.checkbox.CheckBoxEvent;
  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class SingleActionWithCheckBoxPanel extends SingleActionPanel {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private static const CALLBACK_DELAY:int = 1000;

    private var checkBox:CheckBoxBase;
    private var lastValue:Boolean;
    private var timeoutCallback:uint;
    private var callbackCheckBoxChanged:Function;

    public function SingleActionWithCheckBoxPanel(param1:String, param2:Function) {
      super(param1,param2);
    }

    public function initCheckBox(param1:String, param2:Boolean, param3:Function) : void {
      this.callbackCheckBoxChanged = param3;
      this.checkBox = new CheckBoxBase();
      this.checkBox.addEventListener(CheckBoxEvent.STATE_CHANGED,this.handleChangedValue);
      this.checkBox.label = localeService.getText(param1);
      this.checkBox.checked = param2;
      if(actionButton.visible) {
        this.checkBox.y = actionButton.height - this.checkBox.height >> 1;
        this.checkBox.x = actionButton.x + actionButton.width + 15;
      } else {
        this.checkBox.x = 11;
        this.checkBox.y = 8;
      }
      this.lastValue = param2;
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.handleLayoutSwitch);
    }

    private function handleLayoutSwitch(param1:Event) : void {
      this.callback();
    }

    override public function updateActionElements(param1:DisplayObjectContainer) : void {
      super.updateActionElements(param1);
      param1.addChild(this.checkBox);
    }

    override public function close() : void {
      super.close();
      this.checkBox.removeEventListener(CheckBoxEvent.STATE_CHANGED,this.handleChangedValue);
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.BEGIN_LAYOUT_SWITCH,this.handleLayoutSwitch);
      clearTimeout(this.timeoutCallback);
    }

    private function handleChangedValue(param1:CheckBoxEvent) : void {
      clearTimeout(this.timeoutCallback);
      this.timeoutCallback = setTimeout(this.callback,CALLBACK_DELAY);
    }

    private function callback() : void {
      if(this.lastValue != this.checkBox.checked) {
        this.lastValue = this.checkBox.checked;
        this.callbackCheckBoxChanged();
      }
    }

    public function isChecked() : Boolean {
      return this.checkBox.checked;
    }

    override public function set enabled(param1:Boolean) : void {
      super.enabled = param1;
      this.checkBox.visible = param1;
    }
  }
}
