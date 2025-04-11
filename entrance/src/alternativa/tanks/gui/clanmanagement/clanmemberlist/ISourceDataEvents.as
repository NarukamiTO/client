package alternativa.tanks.gui.clanmanagement.clanmemberlist {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ISourceDataEvents implements ISourceData {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ISourceDataEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function addByUid(param1:String) : void {
      var i:int = 0;
      var m:ISourceData = null;
      var name:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ISourceData(this.impl[i]);
          m.addByUid(name);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function checkUid(param1:String) : void {
      var i:int = 0;
      var m:ISourceData = null;
      var name:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ISourceData(this.impl[i]);
          m.checkUid(name);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setSearchInput(param1:ISearchInput) : void {
      var i:int = 0;
      var m:ISourceData = null;
      var view:ISearchInput = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ISourceData(this.impl[i]);
          m.setSearchInput(view);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function accept(param1:Long) : void {
      var i:int = 0;
      var m:ISourceData = null;
      var userId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ISourceData(this.impl[i]);
          m.accept(userId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
