package platform.client.fp10.core.registry.impl {
  import alternativa.types.Long;
  import platform.client.fp10.core.registry.SpaceRegistry;
  import platform.client.fp10.core.type.ISpace;

  public class SpaceRegistryImpl implements SpaceRegistry {
    private var _spaces:Vector.<ISpace> = new Vector.<ISpace>();
    private var _currentSpace:ISpace;

    public function SpaceRegistryImpl() {
      super();
    }

    public function addSpace(param1:ISpace) : void {
      this._spaces.push(param1);
    }

    public function removeSpace(param1:ISpace) : void {
      var local2:int = int(this._spaces.indexOf(param1));
      if(local2 < 0) {
        throw new Error("Space not found: " + param1.id);
      }
      this._spaces.splice(local2,1);
      if(this._currentSpace == param1) {
        this._currentSpace = null;
      }
    }

    public function get spaces() : Vector.<ISpace> {
      return this._spaces;
    }

    public function getSpace(param1:Long) : ISpace {
      var local2:ISpace = null;
      for each(local2 in this._spaces) {
        if(local2.id == param1) {
          return local2;
        }
      }
      return null;
    }

    public function get currentSpace() : ISpace {
      return this._currentSpace;
    }

    public function set currentSpace(param1:ISpace) : void {
      this._currentSpace = param1;
    }
  }
}
