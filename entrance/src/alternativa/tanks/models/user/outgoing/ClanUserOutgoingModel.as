package alternativa.tanks.models.user.outgoing {
  import alternativa.tanks.gui.notinclan.clanslist.ClansListEvent;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.clans.user.outgoing.ClanUserOutgoingModelBase;
  import projects.tanks.client.clans.user.outgoing.IClanUserOutgoingModelBase;

  [ModelInfo]
  public class ClanUserOutgoingModel extends ClanUserOutgoingModelBase implements IClanUserOutgoingModelBase, ObjectLoadListener, ObjectUnloadListener, IClanUserOutgoingModel {
    [Inject]
    public static var clanUserService:ClanUserService;

    private var clans:Vector.<Long>;

    public function ClanUserOutgoingModel() {
      super();
    }

    public function objectLoaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      this.clans = getInitParam().objects.concat();
    }

    public function objectUnloaded() : void {
      if(!this.isServiceSpace()) {
        return;
      }
      this.clans.length = 0;
    }

    public function onAdding(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      this.clans.push(param1);
      ClansListEvent.getDispatcher().dispatchEvent(new ClansListEvent(ClansListEvent.OUTGOING + ClansListEvent.ADD,param1));
    }

    public function onRemoved(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      var local2:int = int(this.clans.indexOf(param1));
      if(local2 >= 0) {
        this.clans.splice(local2,1);
        ClansListEvent.getDispatcher().dispatchEvent(new ClansListEvent(ClansListEvent.OUTGOING + ClansListEvent.REMOVE,param1));
      }
    }

    public function getOutgoingClans() : Vector.<Long> {
      return this.clans;
    }

    private function isServiceSpace() : Boolean {
      return IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace();
    }
  }
}
