package platform.client.fp10.core.model.impl {
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.IGameObjectInternal;

  public class Model implements IModel {
    private static var currentObject:IGameObject;
    private static var objects:Vector.<IGameObject> = new Vector.<IGameObject>();

    protected var initParams:Dictionary = new Dictionary();

    public function Model() {
      super();
    }

    public static function get object() : IGameObject {
      return currentObject;
    }

    public static function set object(param1:IGameObject) : void {
      objects.push(currentObject);
      currentObject = param1;
    }

    public static function popObject() : void {
      currentObject = objects.pop();
    }

    public function invoke(param1:Long, param2:ProtocolBuffer) : void {
    }

    public function get id() : Long {
      return null;
    }

    public function putInitParams(param1:Object) : void {
      this.initParams[object] = param1;
    }

    public function clearInitParams() : void {
      delete this.initParams[object];
    }

    public function getData(param1:Class) : Object {
      return IGameObjectInternal(currentObject).getData(this,param1);
    }

    public function putData(param1:Class, param2:Object) : void {
      IGameObjectInternal(currentObject).putData(this,param1,param2);
    }

    public function clearData(param1:Class) : Object {
      return IGameObjectInternal(currentObject).clearData(this,param1);
    }

    protected function getFunctionWrapper(param1:Function) : Function {
      var wrapper:Function;
      var object:IGameObject = null;
      var f:Function = param1;
      var wrappers:Dictionary = this.getData(Model) as Dictionary;
      if(wrappers == null) {
        wrappers = new Dictionary();
        this.putData(Model,wrappers);
      }
      wrapper = wrappers[f];
      if(wrapper == null) {
        object = Model.object;
        wrapper = function(... rest):void {
          Model.object = object;
          f.apply(null,rest);
          Model.popObject();
        };
        wrappers[f] = wrapper;
      }
      return wrapper;
    }
  }
}
