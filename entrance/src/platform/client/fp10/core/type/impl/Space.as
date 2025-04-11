package platform.client.fp10.core.type.impl {
  import alternativa.osgi.service.logging.LogService;
  import alternativa.osgi.service.logging.Logger;
  import alternativa.osgi.service.network.INetworkService;
  import alternativa.protocol.IProtocol;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import platform.client.fp10.core.model.ObjectUnloadPostListener;
  import platform.client.fp10.core.network.ICommandSender;
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;
  import platform.client.fp10.core.network.connection.ConnectionConnectParameters;
  import platform.client.fp10.core.network.connection.ConnectionInitializers;
  import platform.client.fp10.core.network.connection.IConnection;
  import platform.client.fp10.core.network.connection.IProtectionContext;
  import platform.client.fp10.core.network.connection.protection.PrimitiveProtectionContext;
  import platform.client.fp10.core.network.connection.protection.XorBasedProtectionContext;
  import platform.client.fp10.core.network.handler.ISpaceCommandHandler;
  import platform.client.fp10.core.protocol.codec.SpaceRootCodec;
  import platform.client.fp10.core.service.errormessage.IErrorMessageService;
  import platform.client.fp10.core.service.transport.ITransportService;
  import platform.client.fp10.core.type.*;

  public class Space implements ISpace {
    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var messageBoxService:IErrorMessageService;

    [Inject]
    public static var networkService:INetworkService;

    [Inject]
    public static var transportService:ITransportService;

    private static var logger:Logger;

    private var _id:Long;
    private var objectById:Dictionary = new Dictionary();
    private var _objects:Vector.<IGameObject>;
    private var connection:IConnection;
    private var listeners:Vector.<ISpaceListener>;

    public function Space(param1:Long, param2:ISpaceCommandHandler, param3:IProtocol, param4:Boolean) {
      super();
      this._id = param1;
      this._objects = new Vector.<IGameObject>();
      logger = logger || logService.getLogger("space");
      this.listeners = new Vector.<ISpaceListener>();
      var local5:IProtectionContext = param4 ? new XorBasedProtectionContext(transportService.hash,param1) : PrimitiveProtectionContext.INSTANCE;
      var local6:ConnectionInitializers = new ConnectionInitializers(param3,new SpaceRootCodec(),param2,networkService.secure,param1,local5);
      this.connection = transportService.createConnection(local6);
      param2.setSpace(this);
      var local7:GameClass = new GameClass(Long.getLong(0,0),new Vector.<Long>());
      this.createObject(param1,local7,"Space object");
    }

    public function connect(param1:String, param2:Vector.<int>) : void {
      this.connection.connect(new ConnectionConnectParameters(param1,param2));
    }

    public function close() : void {
      this.connection.close(ConnectionCloseStatus.SPACE_CLOSED);
      this.invokeSpaceClosedListeners();
    }

    private function invokeSpaceClosedListeners() : void {
      var local2:ISpaceListener = null;
      var local1:Vector.<ISpaceListener> = this.listeners.concat();
      for each(local2 in local1) {
        local2.spaceClosed();
      }
    }

    public function createObject(param1:Long, param2:IGameClass, param3:String) : IGameObject {
      var local4:GameObject = null;
      if(this.objectById[param1] == null) {
        local4 = new GameObject(param1,GameClass(param2),param3,this);
        this.objectById[local4.id] = local4;
        this._objects.push(local4);
      }
      return this.objectById[param1];
    }

    public function destroyObject(param1:Long) : void {
      var objectId:Long = param1;
      var clientObject:GameObject = this.objectById[objectId];
      if(clientObject != null) {
        try {
          this.invokeUnloadListeners(clientObject);
          this.invokeDestructionListeners(clientObject);
        }
        catch(e:Error) {
          processUnloadingError(e,objectId);
        }
        finally {
          this.removeObject(clientObject);
        }
      }
    }

    private function invokeUnloadListeners(param1:IGameObject) : void {
      var local2:IObjectLoadListener = IObjectLoadListener(param1.event(IObjectLoadListener));
      local2.objectUnloaded();
      ObjectUnloadListener(param1.event(ObjectUnloadListener)).objectUnloaded();
      local2.objectUnloadedPost();
      ObjectUnloadPostListener(param1.event(ObjectUnloadPostListener)).objectUnloadedPost();
    }

    private function invokeDestructionListeners(param1:GameObject) : void {
      var local3:ISpaceListener = null;
      var local2:Vector.<ISpaceListener> = this.listeners.concat();
      for each(local3 in local2) {
        local3.objectDestroyed(param1);
      }
    }

    private function processUnloadingError(param1:Error, param2:Long) : void {
    }

    private function removeObject(param1:GameObject) : void {
      this._objects.splice(this._objects.indexOf(param1),1);
      delete this.objectById[param1.id];
      param1.clear();
    }

    public function getObject(param1:Long) : IGameObject {
      return this.objectById[param1];
    }

    public function get objects() : Vector.<IGameObject> {
      return this._objects;
    }

    public function get id() : Long {
      return this._id;
    }

    public function get commandSender() : ICommandSender {
      return this.connection;
    }

    public function get rootObject() : IGameObject {
      return this.getObject(this._id);
    }

    public function addEventListener(param1:ISpaceListener) : void {
      if(this.listeners.indexOf(param1) == -1) {
        this.listeners.push(param1);
      }
    }

    public function removeEventListener(param1:ISpaceListener) : void {
      var local2:int = int(this.listeners.indexOf(param1));
      if(local2 != -1) {
        this.listeners.splice(local2,1);
      }
    }

    public function modelsDataReady(param1:IGameObject) : void {
      var local3:ISpaceListener = null;
      var local2:Vector.<ISpaceListener> = this.listeners.concat();
      for each(local3 in local2) {
        local3.objectCreated(param1);
      }
    }

    public function toString() : String {
      return "[Space id=" + this.id + "]";
    }
  }
}
