package projects.tanks.clients.fp10.libraries.tanksservices.service.helper {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.net.SharedObject;
  import flash.utils.Dictionary;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.AlertUtils;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.KeyUpListenerPriority;

  public class HelpService implements IHelpService {
    private var storage:SharedObject;
    private var stage:Stage;
    private var helpLayer:DisplayObjectContainer;
    private var helpContainer:Sprite;
    private var helpGroups:Dictionary;
    private var mainGroupObjects:Array;
    private var advancedUser:Boolean;
    private var timers:Array;
    private var listenerAdded:Boolean;
    private var currentlyVisibleHelpers:Dictionary;
    private var storedState:Dictionary = new Dictionary();
    private var addedDuringLock:Vector.<ShowedHelperInfo> = new Vector.<ShowedHelperInfo>();
    private var hidedHelpers:Vector.<Object>;
    private var locked:Boolean;

    private const showPeriod:int = 86400000;
    private const showCount:int = 5;

    public function HelpService() {
      super();
      var local1:OSGi = OSGi.getInstance();
      var local2:IDisplay = IDisplay(local1.getService(IDisplay));
      this.stage = local2.stage;
      this.helpLayer = local2.noticesLayer;
      this.helpContainer = new Sprite();
      this.helpGroups = new Dictionary();
      this.mainGroupObjects = new Array();
      this.timers = new Array();
      this.storage = IStorageService(local1.getService(IStorageService)).getStorage();
      if(!this.storage.data.helperShowNum) {
        this.storage.data.helperShowNum = new Vector.<Object>();
      }
      if(this.storage.data.hidedHelpers as Vector.<Object> == null) {
        this.storage.data.hidedHelpers = new Vector.<Object>();
      }
      this.hidedHelpers = this.storage.data.hidedHelpers as Vector.<Object>;
      this.advancedUser = int(this.storage.data.userRank) >= 6;
      this.currentlyVisibleHelpers = new Dictionary();
      this.stage.addEventListener(Event.RESIZE,this.onStageResize);
    }

    public function registerHelper(param1:String, param2:int, param3:Helper, param4:Boolean) : void {
      var local9:Object = null;
      var local5:Dictionary = this.helpGroups[param1];
      if(local5 == null) {
        local5 = new Dictionary();
        this.helpGroups[param1] = local5;
      }
      local5[param2] = param3;
      if(param4) {
        this.mainGroupObjects.push(param3);
      }
      var local6:Vector.<Object> = this.storage.data.helperShowNum != null && this.storage.data.helperShowNum is Vector.<Object> ? this.storage.data.helperShowNum as Vector.<Object> : new Vector.<Object>();
      var local7:int = -1;
      var local8:int = 0;
      while(local8 < local6.length) {
        if(Boolean(local6[local8].hasOwnProperty("groupKey")) && local6[local8].groupKey == param1) {
          local7 = local8;
        }
        local8++;
      }
      if(local7 == -1) {
        local9 = new Object();
        local9.groupKey = param1;
        local9.helper = new Array();
        local6.push(local9);
        local7 = local6.length - 1;
      }
      if(local6[local7].helper == null) {
        local6[local7].helper = new Array();
      }
      if(local6[local7].helper[param2] == null) {
        local6[local7].helper[param2] = param3.showNum;
      } else {
        param3.showNum = local6[local7].helper[param2];
      }
      this.storage.data.helperShowNum = local6;
      param3.id = param2;
      param3.groupKey = param1;
    }

    public function unregisterHelper(param1:String, param2:int) : void {
      var local3:Dictionary = this.helpGroups[param1];
      if(local3 == null) {
        return;
      }
      var local4:Helper = local3[param2];
      if(local4 == null) {
        return;
      }
      this.doHideHelper(local4);
      delete local3[param2];
      var local5:int = int(this.mainGroupObjects.indexOf(local4));
      if(local5 >= 0) {
        this.mainGroupObjects.splice(local5,1);
      }
    }

    public function showHelperIfAble(param1:String, param2:int, param3:Boolean = false) : void {
      if(this.locked) {
        this.addedDuringLock.push(new ShowedHelperInfo(param1,param2,param3));
      } else {
        this.showHelper(param1,param2,param3);
      }
    }

    public function showHelper(param1:String, param2:int, param3:Boolean = false) : void {
      var local5:Vector.<Object> = null;
      var local6:int = 0;
      var local7:int = 0;
      var local8:Object = null;
      var local9:HelperTimer = null;
      if(this.advancedUser || this.helperHiddenManually(param1,param2)) {
        return;
      }
      var local4:Helper = this.getHelper(param1,param2);
      if(local4 == null) {
        return;
      }
      if(!this.helpLayer.contains(this.helpContainer)) {
        this.helpLayer.addChild(this.helpContainer);
      }
      if(param3 || local4.showLimit == -1 || local4.showNum < local4.showLimit) {
        if(!this.helpContainer.contains(local4)) {
          ++local4.showNum;
          this.currentlyVisibleHelpers[local4] = new ShowedHelperInfo(param1,param2,param3);
          local5 = this.storage.data.helperShowNum != null && this.storage.data.helperShowNum is Vector.<Object> ? this.storage.data.helperShowNum as Vector.<Object> : new Vector.<Object>();
          local6 = -1;
          local7 = 0;
          while(local7 < local5.length) {
            if(Boolean(local5[local7].hasOwnProperty("groupKey")) && local5[local7].groupKey == param1) {
              local6 = local7;
            }
            local7++;
          }
          if(local6 == -1) {
            local8 = new Object();
            local8.groupKey = param1;
            local8.helper = new Array();
            local8.helper[param2] = local4.showNum;
            local5.push(local8);
          } else {
            local5[local6].helper[param2] = local4.showNum;
          }
          this.storage.data.helperShowNum = local5;
          this.helpContainer.addChild(local4);
          local4.draw(local4.size);
          local4.align(this.stage.stageWidth,this.stage.stageHeight);
          local4.addEventListener(MouseEvent.MOUSE_DOWN,this.onHelperClick);
          if(!param3) {
            local9 = new HelperTimer(local4.showDuration,1);
            local9.helper = local4;
            local4.timer = local9;
            local9.addEventListener(TimerEvent.TIMER_COMPLETE,this.onHelperTimer);
            this.timers.push(local9);
            local9.start();
          }
        }
      }
    }

    private function helperHiddenManually(param1:String, param2:int) : Boolean {
      var local4:Object = null;
      var local3:Date = new Date();
      for each(local4 in this.hidedHelpers) {
        if(local4.groupKey == param1 && local4.helperId == param2) {
          return local3.time - local4.date.time < this.showPeriod || local4.count >= this.showCount;
        }
      }
      return false;
    }

    public function hideAllHelpers() : void {
      var local1:Helper = null;
      if(this.helpContainer != null) {
        while(this.helpContainer.numChildren != 0) {
          local1 = this.helpContainer.getChildAt(0) as Helper;
          this.hideHelper(local1.groupKey,local1.id);
        }
        if(this.helpContainer.numChildren == 0 && this.helpLayer.contains(this.helpContainer)) {
          this.helpLayer.removeChild(this.helpContainer);
        }
      }
    }

    public function hideHelper(param1:String, param2:int) : void {
      if(this.currentlyVisibleHelpers[this.getHelper(param1,param2)] != null) {
        delete this.currentlyVisibleHelpers[this.getHelper(param1,param2)];
      }
      this.doHideHelper(this.getHelper(param1,param2));
      this.checkContainerEmptiness();
    }

    private function checkContainerEmptiness() : void {
      if(this.helpContainer.numChildren == 0 && this.helpLayer.contains(this.helpContainer)) {
        this.helpLayer.removeChild(this.helpContainer);
      }
    }

    public function showHelp() : void {
      var local2:Helper = null;
      var local3:int = 0;
      if(!this.helpLayer.contains(this.helpContainer)) {
        this.helpLayer.addChild(this.helpContainer);
      }
      var local1:int = 0;
      while(local1 < this.mainGroupObjects.length) {
        local2 = this.mainGroupObjects[local1] as Helper;
        if(!this.helpContainer.contains(local2)) {
          this.helpContainer.addChild(local2);
          local2.draw(local2.size);
          local2.align(this.stage.stageWidth,this.stage.stageHeight);
        } else {
          local3 = int(this.timers.indexOf(local2.timer));
          if(local3 != -1) {
            HelperTimer(this.timers[local3]).stop();
            this.timers.splice(local3,1);
          }
        }
        this.currentlyVisibleHelpers[local2] = new ShowedHelperInfo(local2.groupKey,local2.id,true);
        local1++;
      }
      if(!this.listenerAdded) {
        this.listenerAdded = true;
        this.stage.addEventListener(MouseEvent.CLICK,this.onStageMouseClick,true);
        this.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp,false,KeyUpListenerPriority.HELP);
      }
    }

    private function onKeyUp(param1:KeyboardEvent) : void {
      if(AlertUtils.isCancelKey(param1.keyCode)) {
        param1.stopImmediatePropagation();
        this.hideHelp();
      }
    }

    public function hideHelp() : void {
      var local2:Helper = null;
      var local3:int = 0;
      var local1:int = 0;
      while(local1 < this.mainGroupObjects.length) {
        local2 = this.mainGroupObjects[local1];
        local3 = int(this.timers.indexOf(local2.timer));
        if(local3 != -1) {
          (this.timers[local3] as HelperTimer).stop();
          this.timers.splice(local3,1);
        }
        if(this.helpContainer.contains(local2)) {
          this.helpContainer.removeChild(local2);
        }
        if(this.currentlyVisibleHelpers[local2] != null) {
          delete this.currentlyVisibleHelpers[local2];
        }
        local1++;
      }
      this.checkContainerEmptiness();
      if(this.listenerAdded) {
        this.listenerAdded = false;
        this.stage.removeEventListener(MouseEvent.CLICK,this.onStageMouseClick,true);
        this.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
      }
    }

    public function pushState() : void {
      var local1:Object = null;
      this.storedState = new Dictionary();
      for(local1 in this.currentlyVisibleHelpers) {
        this.storedState[local1] = this.currentlyVisibleHelpers[local1];
      }
    }

    public function popState() : void {
      var local1:Object = null;
      for(local1 in this.storedState) {
        this.showHelper(this.storedState[local1].groupKey,this.storedState[local1].helperId,this.storedState[local1].force);
      }
      this.storedState = new Dictionary();
    }

    private function onStageMouseClick(param1:MouseEvent) : void {
      this.hideHelp();
      param1.stopPropagation();
    }

    private function onHelperTimer(param1:TimerEvent) : void {
      var local2:HelperTimer = param1.target as HelperTimer;
      var local3:Helper = local2.helper;
      this.hideHelper(local3.groupKey,local3.id);
    }

    private function onHelperClick(param1:MouseEvent) : void {
      var local2:Helper = null;
      if(param1.target is Helper) {
        local2 = param1.target as Helper;
        this.hideHelper(local2.groupKey,local2.id);
        this.addHidedHelper(local2);
        param1.stopPropagation();
      }
    }

    private function addHidedHelper(param1:Helper) : void {
      var local4:Object = null;
      var local2:Date = new Date();
      var local3:Boolean = false;
      for each(local4 in this.hidedHelpers) {
        if(local4.groupKey == param1.groupKey && local4.helperId == param1.id) {
          local4.date = local2;
          ++local4.count;
          local3 = true;
        }
      }
      if(!local3) {
        this.hidedHelpers.push(new HidedHelperInfo(param1.groupKey,param1.id,local2,0));
      }
    }

    private function onStageResize(param1:Event) : void {
      var local2:int = 0;
      var local3:Helper = null;
      if(this.helpLayer.contains(this.helpContainer)) {
        local2 = 0;
        while(local2 < this.helpContainer.numChildren) {
          local3 = this.helpContainer.getChildAt(local2) as Helper;
          if(local3 != null) {
            local3.align(this.stage.stageWidth,this.stage.stageHeight);
          }
          local2++;
        }
      }
    }

    private function getHelper(param1:String, param2:int) : Helper {
      var local3:Dictionary = this.helpGroups[param1];
      if(local3 == null) {
        return null;
      }
      return local3[param2];
    }

    private function doHideHelper(param1:Helper) : void {
      var local3:int = 0;
      if(param1 == null) {
        return;
      }
      if(this.helpContainer.contains(param1)) {
        this.helpContainer.removeChild(param1);
      }
      param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHelperClick);
      var local2:HelperTimer = param1.timer;
      if(local2 != null) {
        local2.stop();
        local3 = int(this.timers.indexOf(local2));
        if(local3 != -1) {
          this.timers.splice(local3,1);
        }
      }
    }

    public function lock() : void {
      this.locked = true;
    }

    public function unlock() : void {
      var local1:ShowedHelperInfo = null;
      this.locked = false;
      for each(local1 in this.addedDuringLock) {
        this.showHelper(local1.groupKey,local1.helperId,local1.force);
      }
      this.addedDuringLock = new Vector.<ShowedHelperInfo>();
    }

    public function manuallyShutDownHelper(param1:Helper) : void {
      this.hideHelper(param1.groupKey,param1.id);
      this.addHidedHelper(param1);
    }
  }
}

class ShowedHelperInfo {
  public var groupKey:String;
  public var helperId:int;
  public var force:Boolean = false;

  public function ShowedHelperInfo(param1:String, param2:int, param3:Boolean) {
    super();
    this.groupKey = param1;
    this.helperId = param2;
    this.force = param3;
  }
}

class HidedHelperInfo {
  public var groupKey:String;
  public var helperId:int;
  public var date:Date;
  public var count:int;

  public function HidedHelperInfo(param1:String, param2:int, param3:Date, param4:int) {
    super();
    this.groupKey = param1;
    this.helperId = param2;
    this.date = param3;
    this.count = param4;
  }

  public function toString() : String {
    return this.date.toString() + ", " + this.count.toString();
  }
}
