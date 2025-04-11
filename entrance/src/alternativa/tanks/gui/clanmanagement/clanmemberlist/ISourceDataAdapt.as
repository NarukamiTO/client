package alternativa.tanks.gui.clanmanagement.clanmemberlist {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ISourceDataAdapt implements ISourceData {
    private var object:IGameObject;
    private var impl:ISourceData;

    public function ISourceDataAdapt(param1:IGameObject, param2:ISourceData) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function addByUid(param1:String) : void {
      var name:String = param1;
      try {
        Model.object = this.object;
        this.impl.addByUid(name);
      }
      finally {
        Model.popObject();
      }
    }

    public function checkUid(param1:String) : void {
      var name:String = param1;
      try {
        Model.object = this.object;
        this.impl.checkUid(name);
      }
      finally {
        Model.popObject();
      }
    }

    public function setSearchInput(param1:ISearchInput) : void {
      var view:ISearchInput = param1;
      try {
        Model.object = this.object;
        this.impl.setSearchInput(view);
      }
      finally {
        Model.popObject();
      }
    }

    public function accept(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.accept(userId);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
