package alternativa.tanks.gui.settings.tabs.control {
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.service.settings.keybinding.KeyBindingChangeEvent;
  import alternativa.tanks.service.settings.keybinding.KeysBindingService;
  import alternativa.tanks.service.settings.keybinding.KeysBindingServiceImpl;
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import controls.base.TankInput;
  import controls.containers.HorizontalStackPanel;
  import flash.events.KeyboardEvent;
  import flash.text.TextFormatAlign;
  import flash.ui.Keyboard;

  public class KeyBinding extends DiscreteSprite {
    [Inject]
    public static var keysBindingService:KeysBindingService;

    public static const KEY_INPUT_WIDTH:int = 120;

    private var keyInputs:Vector.<TankInput> = new Vector.<TankInput>(3,true);
    private var action:GameActionEnum;

    public function KeyBinding(param1:GameActionEnum, param2:String, param3:int, param4:int) {
      super();
      this.action = param1;
      var local5:int = param4 - 6 * param3 - KEY_INPUT_WIDTH * 3;
      var local6:HorizontalStackPanel = new HorizontalStackPanel();
      local6.setMargin(param3);
      local6.x = local5 + param3;
      var local7:int = 0;
      while(local7 < 3) {
        local6.addItem(this.createKeyInput(local7));
        local7++;
      }
      var local8:LabelBase = new LabelBase();
      local8.text = param2;
      local8.x = 0;
      local8.y = Math.round((this.keyInputs[0].height - local8.textHeight) * 0.5) - 2;
      addChild(local8);
      addChild(local6);
      keysBindingService.addEventListener(KeyBindingChangeEvent.KEY_BINDING_CHANGE + param1.name,this.keyChanged);
    }

    private function keyChanged(param1:KeyBindingChangeEvent) : void {
      var local2:int = 0;
      while(local2 < this.keyInputs.length) {
        this.keyInputs[local2].value = this.getKeyBindingStringFromService(local2);
        local2++;
      }
    }

    private function getKeyBindingStringFromService(param1:uint) : String {
      var local2:uint = uint(keysBindingService.getKeyBinding(this.action,param1));
      return keysBindingService.getKeyCodeLabel(local2);
    }

    public function getAction() : GameActionEnum {
      return this.action;
    }

    private function createKeyInput(param1:int) : TankInput {
      var local2:TankInput = new TankInput();
      local2.addEventListener(KeyboardEvent.KEY_UP,this.onKeyDown);
      local2.maxChars = 1;
      local2.width = KEY_INPUT_WIDTH;
      local2.align = TextFormatAlign.CENTER;
      local2.value = this.getKeyBindingStringFromService(param1);
      this.keyInputs[param1] = local2;
      return local2;
    }

    private function onKeyDown(param1:KeyboardEvent) : void {
      var local4:Boolean = false;
      var local2:TankInput = TankInput(param1.currentTarget);
      if(param1.keyCode == Keyboard.BACKSPACE || param1.keyCode == Keyboard.DELETE) {
        if(keysBindingService.setKeyBinding(this.action,KeysBindingServiceImpl.BINDING_KEY_NOT_DEFINED,this.keyInputs.indexOf(local2))) {
          local2.value = "";
        } else {
          local2.value = this.getKeyBindingStringFromService(this.keyInputs.indexOf(local2));
        }
        return;
      }
      var local3:String = keysBindingService.getKeyCodeLabel(param1.keyCode);
      if(local3 != "") {
        local4 = Boolean(keysBindingService.setKeyBinding(this.action,param1.keyCode,this.keyInputs.indexOf(local2)));
        local2.value = local4 ? local3 : "";
      } else {
        local2.value = this.getKeyBindingStringFromService(this.keyInputs.indexOf(local2));
      }
    }

    public function restoreDefaultBinding() : void {
      var local1:Vector.<uint> = keysBindingService.getKeyBindings(this.action);
      if(!local1) {
        return;
      }
      var local2:int = 0;
      while(local2 < local1.length) {
        this.keyInputs[local2].value = keysBindingService.getKeyCodeLabel(local1[local2]);
        local2++;
      }
    }

    public function destroy() : void {
      var local1:TankInput = null;
      for each(local1 in this.keyInputs) {
        local1.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
      }
      this.keyInputs = null;
      keysBindingService.removeEventListener(KeyBindingChangeEvent.KEY_BINDING_CHANGE + this.action.name,this.keyChanged);
    }
  }
}
