package platform.client.fp10.core.resource {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.console.IConsole;
  import alternativa.osgi.service.launcherparams.ILauncherParams;
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.types.Long;
  import flash.events.NetStatusEvent;
  import flash.net.SharedObject;
  import flash.net.SharedObjectFlushStatus;
  import flash.system.Capabilities;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.errormessage.errors.SharedObjectUsNotAccessibleError;
  import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;

  public class ResourceLocalStorage implements IResourceLocalStorage, IResourceLocalStorageInternal {
    private var logger:Logger;
    private var _enabled:Boolean;
    private var soStorage:SharedObject;
    private var resourceIndex:ResourceIndex;
    private var temporaryStorageState:Boolean;
    private var consoleCommands:Object;

    public function ResourceLocalStorage(param1:OSGi) {
      super();
      var local2:LogService = LogService(param1.getService(LogService));
      this.logger = local2.getLogger(ResourceLogChannel.NAME);
      this.soStorage = SharedObject.getLocal("localstorage","/");
      this.resourceIndex = new ResourceIndex(this.soStorage);
      var local3:ILauncherParams = ILauncherParams(param1.getService(ILauncherParams));
      var local4:String = local3.getParameter("uselocalstorage");
      if(local4 == "1") {
        this.enableStorage(true);
      } else if(local4 == "0") {
        this._enabled = false;
      } else {
        this._enabled = this.soStorage.data.enabled;
      }
      this.initConsoleCommands(param1);
    }

    public function get enabled() : Boolean {
      return this._enabled;
    }

    public function set enabled(param1:Boolean) : void {
      if(param1) {
        this.enableStorage(false);
      } else {
        this.temporaryStorageState = false;
        this.setEnabledInternal(false);
      }
    }

    public function getResourceData(param1:Long, param2:int, param3:String) : ByteArray {
      var local4:ResourceObject = new ResourceObject(param1.toString(),param3);
      if(local4.resourceVersion == param2) {
        return local4.data;
      }
      this.resourceIndex.removeResourceData(local4.resourceId,param3);
      local4.clear();
      return null;
    }

    public function setResourceData(param1:Long, param2:int, param3:ByteArray, param4:String, param5:String) : void {
      param5 ||= Resource.DEFAULT_CLASSIFIER;
      var local6:ResourceObject = new ResourceObject(param1.toString(),param5);
      local6.resourceVersion = param2;
      local6.data = param3;
      local6.flush();
      this.resourceIndex.addResourceData(local6.resourceId,param5,param4);
    }

    public function clearResourceData(param1:Long) : void {
      this.clearResourceDataStr(param1.toString());
    }

    public function clear() : void {
      var local2:String = null;
      var local1:Vector.<String> = this.resourceIndex.getResourceIds();
      for each(local2 in local1) {
        this.clearResourceDataStr(local2);
      }
    }

    public function flushIndex() : void {
      this.soStorage.flush();
    }

    public function clearResourceDataStr(param1:String) : void {
      var local3:String = null;
      var local4:ResourceObject = null;
      var local2:ResourceInfo = this.resourceIndex.getResourceInfo(param1);
      if(local2.empty) {
        return;
      }
      for each(local3 in local2.classifiers) {
        local4 = new ResourceObject(param1,local3);
        local4.clear();
      }
      this.resourceIndex.removeResourceInfo(param1);
    }

    public function getResourceIndex() : ResourceIndex {
      return this.resourceIndex;
    }

    private function enableStorage(param1:Boolean) : void {
      var flushStatus:String = null;
      var errorType:SharedObjectUsNotAccessibleError = null;
      var messageBoxService:IErrorMessageService = null;
      var temporary:Boolean = param1;
      this.temporaryStorageState = temporary;
      try {
        flushStatus = this.soStorage.flush(100 * (1 << 20));
      }
      catch(e:Error) {
        errorType = new SharedObjectUsNotAccessibleError();
        logger.warning(errorType.getMessage());
        messageBoxService = IErrorMessageService(OSGi.getInstance().getService(IErrorMessageService));
        messageBoxService.showMessage(errorType);
      }
      switch(flushStatus) {
        case SharedObjectFlushStatus.FLUSHED:
          this.setEnabledInternal(true);
          break;
        case SharedObjectFlushStatus.PENDING:
          this.soStorage.addEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
      }
    }

    private function onNetStatus(param1:NetStatusEvent) : void {
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = 0;
      this.soStorage.removeEventListener(NetStatusEvent.NET_STATUS,this.onNetStatus);
      if(param1.info.code == "SharedObject.Flush.Failed") {
        local2 = Capabilities.os.indexOf("Windows");
        local3 = Capabilities.os.indexOf("Linux");
        local4 = Capabilities.os.indexOf("Mac");
        if(local2 >= 0 || (local3 >= 0 || local4 >= 0) && this.soStorage.flush(100 * (1 << 20)) == SharedObjectFlushStatus.PENDING) {
          this.setEnabledInternal(false);
        } else {
          this.setEnabledInternal(true);
        }
      } else {
        this.setEnabledInternal(true);
      }
    }

    private function setEnabledInternal(param1:Boolean) : void {
      if(!this.temporaryStorageState) {
        this.soStorage.data.enabled = param1;
      }
      this._enabled = param1;
    }

    private function initConsoleCommands(param1:OSGi) : void {
      var local2:IConsole = IConsole(param1.getService(IConsole));
      local2.setCommandHandler("locstor",this.onConsoleCommand);
      this.consoleCommands = {};
      this.addConsoleCommand(new PrintIndexCommand("ls",this));
      this.addConsoleCommand(new DeleteResourceCommand("del",this));
      this.addConsoleCommand(new ClearStorageCommand("clear",this));
      this.addConsoleCommand(new StatusCommand("status",this));
      this.addConsoleCommand(new EnableStorageCommand("enable",this));
      this.addConsoleCommand(new DisableStorageCommand("disable",this));
      this.addConsoleCommand(new FlushStorageIndexCommand("flush",this));
    }

    private function addConsoleCommand(param1:ConsoleCommand) : void {
      this.consoleCommands[param1.name] = param1;
    }

    private function onConsoleCommand(param1:IConsole, param2:Array) : void {
      var local4:Array = null;
      var local5:String = null;
      var local3:ConsoleCommand = this.consoleCommands[param2.shift()];
      if(local3 == null) {
        param1.addText("Usage: locstor command [command arguments]");
        param1.addText("Available commands are:");
        local4 = [];
        for(local5 in this.consoleCommands) {
          local4.push(local5);
        }
        local4.sort();
        for each(local5 in local4) {
          param1.addText(ConsoleCommand(this.consoleCommands[local5]).description);
        }
        return;
      }
      local3.execute(param1,param2);
    }
  }
}

import alternativa.osgi.service.console.IConsole;
import flash.net.SharedObject;
import flash.utils.ByteArray;
class ResourceObject {
  private var sharedObject:SharedObject;
  private var _resourceId:String;

  public function ResourceObject(param1:String, param2:String) {
    super();
    var local3:String = param1 + "-" + param2;
    this.sharedObject = SharedObject.getLocal(local3,"/");
    this._resourceId = param1;
  }

  public function get resourceId() : String {
    return this._resourceId;
  }

  public function get resourceVersion() : int {
    return this.sharedObject.data.version;
  }

  public function set resourceVersion(param1:int) : void {
    this.sharedObject.data.version = param1;
  }

  public function get data() : ByteArray {
    return this.sharedObject.data.data;
  }

  public function set data(param1:ByteArray) : void {
    this.sharedObject.data.data = param1;
  }

  public function flush() : void {
    this.sharedObject.flush();
  }

  public function clear() : void {
    this.sharedObject.clear();
  }
}

class ResourceIndex {
  private var sharedObject:SharedObject;
  private var index:Object;

  public function ResourceIndex(param1:SharedObject) {
    super();
    this.sharedObject = param1;
    this.index = param1.data.index;
    if(this.index == null) {
      this.index = {};
      param1.data.index = this.index;
    }
  }

  public function getResourceInfo(param1:String) : ResourceInfo {
    return new ResourceInfo(this.index[param1]);
  }

  public function setResourceInfo(param1:String, param2:ResourceInfo) : void {
    if(param2 == null) {
      this.removeResourceInfo(param1);
    } else {
      this.index[param1] = param2.rawData;
    }
  }

  public function removeResourceInfo(param1:String) : void {
    delete this.index[param1];
  }

  public function addResourceData(param1:String, param2:String, param3:String) : void {
    var local4:ResourceInfo = this.getResourceInfo(param1);
    local4.description = param3;
    var local5:Array = local4.classifiers;
    if(local5.indexOf(param2) < 0) {
      local5.push(param2);
    }
    this.setResourceInfo(param1,local4);
  }

  public function removeResourceData(param1:String, param2:String) : void {
    var local3:ResourceInfo = this.getResourceInfo(param1);
    if(local3.empty) {
      return;
    }
    var local4:Array = local3.classifiers;
    var local5:int = local4.indexOf(param2);
    if(local5 >= 0) {
      if(local4.length == 1) {
        this.removeResourceInfo(param1);
      } else {
        local4.splice(local5,1);
        this.setResourceInfo(param1,local3);
      }
    }
  }

  public function getResourceIds() : Vector.<String> {
    var local2:String = null;
    var local1:Vector.<String> = new Vector.<String>();
    for(local2 in this.index) {
      local1.push(local2);
    }
    return local1;
  }
}

class ConsoleCommand {
  public var name:String;
  public var description:String;

  protected var storage:ResourceLocalStorage;

  public function ConsoleCommand(param1:String, param2:ResourceLocalStorage) {
    super();
    this.name = param1;
    this.storage = param2;
  }

  public function execute(param1:IConsole, param2:Array) : void {
  }
}

class PrintIndexCommand extends ConsoleCommand {
  public function PrintIndexCommand(param1:String, param2:ResourceLocalStorage) {
    super(param1,param2);
    description = param1 + " -- lists all locally stored resources";
  }

  override public function execute(param1:IConsole, param2:Array) : void {
    var counter:int = 0;
    var sid:String = null;
    var resourceInfo:ResourceInfo = null;
    var console:IConsole = param1;
    var params:Array = param2;
    var resourceIndex:ResourceIndex = storage.getResourceIndex();
    var resourceIds:Vector.<String> = resourceIndex.getResourceIds();
    resourceIds.sort(function(param1:String, param2:String):Number {
      if(param1 < param2) {
        return -1;
      }
      if(param1 > param2) {
        return 1;
      }
      return 0;
    });
    for each(sid in resourceIds) {
      resourceInfo = resourceIndex.getResourceInfo(sid);
      console.addText(++counter + ". " + sid + ": " + resourceInfo.description + ", " + resourceInfo.classifiers);
    }
  }
}

class DeleteResourceCommand extends ConsoleCommand {
  public function DeleteResourceCommand(param1:String, param2:ResourceLocalStorage) {
    super(param1,param2);
    description = param1 + " resource_id -- removes locally stored resource with given id";
  }

  override public function execute(param1:IConsole, param2:Array) : void {
    var local3:String = param2[0];
    if(!local3) {
      param1.addText("Resource id should be specified");
      return;
    }
    storage.clearResourceDataStr(local3);
    param1.addText("Resource " + local3 + " has been removed from local storage");
  }
}

class ClearStorageCommand extends ConsoleCommand {
  public function ClearStorageCommand(param1:String, param2:ResourceLocalStorage) {
    super(param1,param2);
    description = param1 + " -- wipes out all locally stored resources";
  }

  override public function execute(param1:IConsole, param2:Array) : void {
    storage.clear();
    param1.addText("Local storage has been cleared");
  }
}

class StatusCommand extends ConsoleCommand {
  public function StatusCommand(param1:String, param2:ResourceLocalStorage) {
    super(param1,param2);
    description = param1 + " -- prints local storage status";
  }

  override public function execute(param1:IConsole, param2:Array) : void {
    param1.addText("Local storage is " + (!!storage.enabled ? "enabled" : "disabled"));
  }
}

class EnableStorageCommand extends ConsoleCommand {
  public function EnableStorageCommand(param1:String, param2:ResourceLocalStorage) {
    super(param1,param2);
    description = param1 + " -- enables local storage";
  }

  override public function execute(param1:IConsole, param2:Array) : void {
    storage.enabled = true;
    param1.addText("Locale storage enabled");
  }
}

class DisableStorageCommand extends ConsoleCommand {
  public function DisableStorageCommand(param1:String, param2:ResourceLocalStorage) {
    super(param1,param2);
    description = param1 + " -- disables local storage";
  }

  override public function execute(param1:IConsole, param2:Array) : void {
    storage.enabled = false;
    param1.addText("Locale storage disabled");
  }
}

class FlushStorageIndexCommand extends ConsoleCommand {
  public function FlushStorageIndexCommand(param1:String, param2:ResourceLocalStorage) {
    super(param1,param2);
    description = param1 + " -- writes storage index to disk";
  }

  override public function execute(param1:IConsole, param2:Array) : void {
    storage.flushIndex();
  }
}

class ResourceInfo {
  public var empty:Boolean;
  public var rawData:Object;

  public function ResourceInfo(param1:Object) {
    super();
    if(param1 == null) {
      this.empty = true;
      this.rawData = {};
    } else {
      this.rawData = param1;
    }
  }

  public function get description() : String {
    return this.rawData.description;
  }

  public function set description(param1:String) : void {
    this.rawData.description = param1;
  }

  public function get classifiers() : Array {
    var local1:Array = this.rawData.classifiers;
    if(local1 == null) {
      local1 = [];
      this.rawData.classifiers = local1;
    }
    return local1;
  }
}
