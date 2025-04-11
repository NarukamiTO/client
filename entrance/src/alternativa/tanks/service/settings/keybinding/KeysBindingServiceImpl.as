package alternativa.tanks.service.settings.keybinding {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.events.EventDispatcher;
  import flash.net.SharedObject;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.LocaleServiceLangValues;

  public class KeysBindingServiceImpl extends EventDispatcher implements KeysBindingService {
    public static const MAX_BINDING_KEY_ON_ACTION:int = 3;
    public static const BINDING_KEY_NOT_DEFINED:uint = 0;

    private var storageService:IStorageService;
    private var bindingsKeyToAction:Dictionary = new Dictionary();
    private var bindingsActionToKey:Dictionary = new Dictionary();
    private var defaultKeyLeft:uint;
    private var defaultBindings:Dictionary = new Dictionary();
    private var keyCodesConverter:KeyCodesConverter;

    public function KeysBindingServiceImpl() {
      super();
      var local1:ILocaleService = ILocaleService(OSGi.getInstance().getService(ILocaleService));
      this.storageService = IStorageService(OSGi.getInstance().getService(IStorageService));
      this.defaultKeyLeft = local1.language == LocaleServiceLangValues.DE ? Keyboard.Y : Keyboard.Z;
      this.initDefaultBindings();
      this.restoreBindingsFromStorage();
    }

    private static function isNullKeyCode(param1:uint) : Boolean {
      return param1 == BINDING_KEY_NOT_DEFINED;
    }

    private static function initNewKeyBindingVector() : Vector.<uint> {
      return new Vector.<uint>(MAX_BINDING_KEY_ON_ACTION,true);
    }

    private function getKeyCodesConverter() : KeyCodesConverter {
      if(!this.keyCodesConverter) {
        this.keyCodesConverter = new KeyCodesConverter();
      }
      return this.keyCodesConverter;
    }

    public function isFreeKey(param1:uint) : Boolean {
      return this.bindingsKeyToAction[param1] == null;
    }

    public function setKeyBinding(param1:GameActionEnum, param2:uint, param3:int) : Boolean {
      var local5:GameActionEnum = null;
      var local6:Vector.<uint> = null;
      var local7:int = 0;
      if(param3 >= MAX_BINDING_KEY_ON_ACTION) {
        return false;
      }
      if(!this.isFreeKey(param2)) {
        local5 = this.bindingsKeyToAction[param2];
        local6 = this.bindingsActionToKey[local5];
        local7 = int(local6.indexOf(param2));
        delete this.bindingsKeyToAction[param2];
        local6[local7] = BINDING_KEY_NOT_DEFINED;
        this.storeKeyBinding(local5,local6);
        dispatchEvent(new KeyBindingChangeEvent(KeyBindingChangeEvent.KEY_BINDING_CHANGE + local5.name,local5));
      }
      var local4:uint = this.getKeyBinding(param1,param3);
      if(!isNullKeyCode(local4) && local4 != param2) {
        delete this.bindingsKeyToAction[local4];
      }
      this.bindingsKeyToAction[param2] = param1;
      this.bindingsActionToKey[param1][param3] = param2;
      this.storeKeyBinding(param1,this.bindingsActionToKey[param1]);
      return true;
    }

    private function storeKeyBinding(param1:GameActionEnum, param2:Vector.<uint> = null) : void {
      if(!param2) {
        param2 = initNewKeyBindingVector();
      }
      var local3:SharedObject = this.storageService.getStorage();
      local3.data[param1.name] = param2;
      local3.flush();
    }

    public function getKeyBinding(param1:GameActionEnum, param2:uint) : uint {
      if(param2 >= MAX_BINDING_KEY_ON_ACTION) {
        return BINDING_KEY_NOT_DEFINED;
      }
      var local3:Vector.<uint> = this.bindingsActionToKey[param1];
      if(Boolean(local3)) {
        return local3[param2];
      }
      return BINDING_KEY_NOT_DEFINED;
    }

    public function getKeyBindings(param1:GameActionEnum) : Vector.<uint> {
      return this.bindingsActionToKey[param1];
    }

    public function getBindingAction(param1:uint) : GameActionEnum {
      return this.bindingsKeyToAction[param1];
    }

    private function initDefaultBindings() : void {
      this.defaultBindings[GameActionEnum.ROTATE_TURRET_LEFT] = Vector.<uint>([this.defaultKeyLeft,Keyboard.COMMA,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.ROTATE_TURRET_RIGHT] = Vector.<uint>([Keyboard.X,Keyboard.PERIOD,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.CENTER_TURRET] = Vector.<uint>([Keyboard.C,Keyboard.SLASH,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.CHASSIS_LEFT_MOVEMENT] = Vector.<uint>([Keyboard.LEFT,Keyboard.A,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.CHASSIS_RIGHT_MOVEMENT] = Vector.<uint>([Keyboard.RIGHT,Keyboard.D,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.CHASSIS_FORWARD_MOVEMENT] = Vector.<uint>([Keyboard.UP,Keyboard.W,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.CHASSIS_BACKWARD_MOVEMENT] = Vector.<uint>([Keyboard.DOWN,Keyboard.S,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.FOLLOW_CAMERA_UP] = Vector.<uint>([Keyboard.PAGE_UP,Keyboard.LEFTBRACKET,Keyboard.Q]);
      this.defaultBindings[GameActionEnum.FOLLOW_CAMERA_DOWN] = Vector.<uint>([Keyboard.PAGE_DOWN,Keyboard.RIGHTBRACKET,Keyboard.E]);
      this.defaultBindings[GameActionEnum.DROP_FLAG] = Vector.<uint>([Keyboard.F,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.BATTLE_PAUSE] = Vector.<uint>([Keyboard.P,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.BATTLE_VIEW_INCREASE] = Vector.<uint>([Keyboard.NUMPAD_ADD,Keyboard.EQUAL,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.BATTLE_VIEW_DECREASE] = Vector.<uint>([Keyboard.O,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.FULL_SCREEN] = Vector.<uint>([Keyboard.O,Keyboard.F11,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.BATTLE_VIEW_INCREASE] = Vector.<uint>([Keyboard.NUMPAD_ADD,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.BATTLE_VIEW_DECREASE] = Vector.<uint>([Keyboard.NUMPAD_SUBTRACT,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.SUICIDE] = Vector.<uint>([Keyboard.DELETE,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.SHOW_TANK_PARAMETERS] = Vector.<uint>([Keyboard.V,Keyboard.R,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.USE_FIRS_AID] = Vector.<uint>([Keyboard.NUMBER_1,Keyboard.NUMPAD_1,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.USE_DOUBLE_ARMOR] = Vector.<uint>([Keyboard.NUMBER_2,Keyboard.NUMPAD_2,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.USE_DOUBLE_DAMAGE] = Vector.<uint>([Keyboard.NUMBER_3,Keyboard.NUMPAD_3,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.USE_NITRO] = Vector.<uint>([Keyboard.NUMBER_4,Keyboard.NUMPAD_4,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.USE_MINE] = Vector.<uint>([Keyboard.NUMBER_5,Keyboard.NUMPAD_5,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.DROP_GOLD_BOX] = Vector.<uint>([Keyboard.NUMBER_6,Keyboard.NUMPAD_6,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.SHOT] = Vector.<uint>([Keyboard.SPACE,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.ULTIMATE] = Vector.<uint>([Keyboard.SHIFT,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.OPEN_GARAGE] = Vector.<uint>([Keyboard.G,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
      this.defaultBindings[GameActionEnum.SHOW_BATTLE_STATS_TABLE] = Vector.<uint>([Keyboard.TAB,BINDING_KEY_NOT_DEFINED,BINDING_KEY_NOT_DEFINED]);
    }

    private function internalSetKeyBinding(param1:GameActionEnum, param2:Vector.<uint>) : void {
      if(!param2) {
        param2 = this.defaultBindings[param1];
        if(!param2) {
          param2 = initNewKeyBindingVector();
        }
      }
      this.bindingsActionToKey[param1] = param2;
      var local3:int = 0;
      while(local3 < MAX_BINDING_KEY_ON_ACTION) {
        this.setKeyBinding(param1,param2[local3],local3);
        local3++;
      }
    }

    public function restoreDefaultBindings() : void {
      var local1:* = undefined;
      this.bindingsActionToKey = new Dictionary();
      this.bindingsKeyToAction = new Dictionary();
      for(local1 in this.defaultBindings) {
        this.internalSetKeyBinding(local1,this.defaultBindings[local1].concat());
      }
    }

    private function restoreBindingsFromStorage() : void {
      var local2:GameActionEnum = null;
      var local1:SharedObject = this.storageService.getStorage();
      for each(local2 in GameActionEnum.values) {
        this.internalSetKeyBinding(local2,local1.data[local2.name]);
      }
    }

    public function getKeyCodeLabel(param1:uint) : String {
      return this.getKeyCodesConverter().keyCodeToString(param1);
    }
  }
}
