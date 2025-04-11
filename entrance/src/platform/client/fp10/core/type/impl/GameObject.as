package platform.client.fp10.core.type.impl {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;
  import platform.client.fp10.core.type.*;

  public class GameObject implements IGameObject, IGameObjectInternal {
    [Inject]
    public static var modelRegistry:ModelRegistry;

    private var _name:String;
    private var _id:Long;
    private var _gameClass:IGameClass;
    private var _space:ISpace;
    private var data:Dictionary = new Dictionary();
    private var adapts:Dictionary;
    private var events:Dictionary;
    private var interfaceToComponentsList:*;
    private var components:Vector.<Component>;

    public function GameObject(param1:Long, param2:IGameClass, param3:String, param4:ISpace) {
      super();
      this._id = param1;
      this._gameClass = param2;
      this._name = param3;
      this._space = param4;
    }

    public function get id() : Long {
      return this._id;
    }

    public function get name() : String {
      return this._name;
    }

    public function get gameClass() : IGameClass {
      return this._gameClass;
    }

    public function get space() : ISpace {
      return this._space;
    }

    public function addComponent(param1:Component) : void {
      this.resetInterfaceCache();
      if(param1.gameObject != null) {
        throw new Error("Component has already added to gameObject " + param1.gameObject);
      }
      if(this.components == null) {
        this.components = new Vector.<Component>();
      }
      this.components.push(param1);
    }

    public function event(param1:Class) : Object {
      var local3:Vector.<Object> = null;
      var local4:Class = null;
      if(this.events == null) {
        this.events = new Dictionary();
      }
      var local2:Object = this.events[param1];
      if(local2 == null) {
        local3 = this.getComponents(param1);
        local4 = modelRegistry.getEventsClass(param1);
        local2 = new local4(this,local3);
        this.events[param1] = local2;
      }
      return local2;
    }

    public function hasModel(param1:Class) : Boolean {
      return this.getComponents(param1).length > 0;
    }

    public function adapt(param1:Class) : Object {
      var local3:Vector.<Object> = null;
      var local4:Class = null;
      if(this.adapts == null) {
        this.adapts = new Dictionary();
      }
      var local2:Object = this.adapts[param1];
      if(local2 == null) {
        local3 = this.getComponents(param1);
        if(local3.length > 1) {
          throw new Error("GameObject::_adapt() Multiple models have been found. Object: " + this + ", interface: " + param1);
        }
        if(local3.length == 0) {
          throw new Error("GameObject::adapt() No models have been found. Object: " + this + ", interface: " + param1);
        }
        local4 = modelRegistry.getAdaptClass(param1);
        local2 = new local4(this,local3[0]);
        this.adapts[param1] = local2;
      }
      return local2;
    }

    public function putData(param1:Model, param2:Class, param3:Object) : void {
      var local4:Dictionary = this.data[param1];
      if(local4 == null) {
        local4 = new Dictionary();
        this.data[param1] = local4;
      }
      local4[param2] = param3;
    }

    public function getData(param1:Model, param2:Class) : Object {
      var local3:Dictionary = this.data[param1];
      return local3 == null ? null : local3[param2];
    }

    public function clearData(param1:Model, param2:Class) : Object {
      var local3:Dictionary = this.data[param1];
      if(local3 == null) {
        return null;
      }
      var local4:Object = local3[param2];
      delete local3[param2];
      return local4;
    }

    public function toString() : String {
      return "[GameObject id=" + this._id + "]";
    }

    private function getComponents(param1:Class) : Vector.<Object> {
      var local3:Long = null;
      var local4:Object = null;
      var local5:Component = null;
      if(this.interfaceToComponentsList == null) {
        this.interfaceToComponentsList = new Dictionary();
      }
      if(param1 in this.interfaceToComponentsList) {
        return this.interfaceToComponentsList[param1];
      }
      var local2:Vector.<Object> = new Vector.<Object>();
      if(this.gameClass != null) {
        for each(local3 in this.gameClass.models) {
          local4 = modelRegistry.getModel(local3);
          if(local4 is param1) {
            local2.push(local4);
          }
        }
      }
      if(this.components != null) {
        for each(local5 in this.components) {
          if(local5 is param1) {
            local2.push(local5);
          }
        }
      }
      this.interfaceToComponentsList[param1] = local2;
      return local2;
    }

    public function clear() : void {
      this.clearModelsInitParams();
      this._gameClass = null;
      this._space = null;
      this.clearModelData();
      this.resetInterfaceCache();
    }

    private function clearModelData() : void {
      var local1:* = undefined;
      var local2:Dictionary = null;
      var local3:* = undefined;
      var local4:* = undefined;
      for(local1 in this.data) {
        local2 = this.data[local1];
        for(local3 in local2) {
          local4 = local2[local3];
          if(local4 is AutoClosable) {
            AutoClosable(local4).close();
          }
          delete local2[local3];
        }
        delete this.data[local1];
      }
    }

    private function clearModelsInitParams() : void {
      var local1:Long = null;
      var local2:IModel = null;
      Model.object = this;
      for each(local1 in this.gameClass.models) {
        local2 = modelRegistry.getModel(local1);
        if(local2 != null) {
          local2.clearInitParams();
        }
      }
      Model.popObject();
    }

    private function resetInterfaceCache() : void {
      this.clearDictionary(this.interfaceToComponentsList);
      this.clearDictionary(this.adapts);
      this.clearDictionary(this.events);
      this.interfaceToComponentsList = null;
      this.adapts = null;
      this.events = null;
    }

    private function clearDictionary(param1:Dictionary) : void {
      var local2:* = undefined;
      if(param1 == null) {
        return;
      }
      for(local2 in param1) {
        delete param1[local2];
      }
    }
  }
}
