package alternativa.tanks.models.user.incoming {
  import alternativa.tanks.gui.notinclan.clanslist.ClansListEvent;
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.tanks.models.user.IClanUserModel;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.user.incoming.ClanUserIncomingModelBase;
  import projects.tanks.client.clans.user.incoming.IClanUserIncomingModelBase;

  [ModelInfo]
  public class ClanUserIncomingModel extends ClanUserIncomingModelBase implements IClanUserIncomingModelBase, ObjectLoadListener, IClanUserIncomingModel {
    [Inject]
    public static var clanUserService:ClanUserService;

    private var clans:Vector.<Long>;

    public function ClanUserIncomingModel() {
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
      ClanUserNotificationsManager.onIncomingNotification(param1);
      ClansListEvent.getDispatcher().dispatchEvent(new ClansListEvent(ClansListEvent.INCOMING + ClansListEvent.ADD,param1));
    }

    public function onRemoved(param1:Long) : void {
      if(!this.isServiceSpace()) {
        return;
      }
      var local2:int = int(this.clans.indexOf(param1));
      if(local2 >= 0) {
        this.clans.splice(local2,1);
        ClansListEvent.getDispatcher().dispatchEvent(new ClansListEvent(ClansListEvent.INCOMING + ClansListEvent.REMOVE,param1));
      }
    }

    public function getIncomingClans() : Vector.<Long> {
      return this.clans;
    }

    private function isServiceSpace() : Boolean {
      return IClanUserModel(object.adapt(IClanUserModel)).loadingInServiceSpace();
    }
  }
}
