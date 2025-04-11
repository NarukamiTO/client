package alternativa.tanks.types {
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;

  public class MultiGameObjectDictionary {
    private var dictionary:Dictionary = new Dictionary(true);

    public function MultiGameObjectDictionary() {
      super();
    }

    public function put(param1:IGameObject, param2:IGameObject) : void {
      var local3:Vector.<IGameObject> = null;
      if(param1 in this.dictionary) {
        this.dictionary[param1].push(param2);
      } else {
        local3 = new Vector.<IGameObject>();
        local3.push(param2);
        this.dictionary[param1] = local3;
      }
    }

    public function getValues(param1:IGameObject) : Vector.<IGameObject> {
      if(param1 in this.dictionary) {
        return this.dictionary[param1];
      }
      return new Vector.<IGameObject>();
    }

    public function clear() : void {
      this.dictionary = new Dictionary();
    }

    public function remove(param1:IGameObject, param2:IGameObject) : void {
      var local3:Vector.<IGameObject> = null;
      var local4:Number = NaN;
      if(param1 in this.dictionary) {
        local3 = this.dictionary[param1];
        local4 = Number(local3.indexOf(param2));
        if(local4 != -1) {
          local3.splice(local4,1);
        }
      }
    }
  }
}
