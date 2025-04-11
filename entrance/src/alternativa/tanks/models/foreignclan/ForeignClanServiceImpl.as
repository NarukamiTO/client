package alternativa.tanks.models.foreignclan {
  import alternativa.tanks.gui.foreignclan.ForeignClanWindow;
  import flash.events.EventDispatcher;
  import projects.tanks.client.clans.panel.foreignclan.ForeignClanData;

  public class ForeignClanServiceImpl extends EventDispatcher implements ForeignClanService {
    private var _foreignClanWindow:ForeignClanWindow;
    private var _isShowForeignClan:Boolean;

    public function ForeignClanServiceImpl() {
      super();
    }

    public function showForeignClan(param1:ForeignClanData) : void {
      this._isShowForeignClan = true;
      this._foreignClanWindow = new ForeignClanWindow(param1);
    }

    public function sendRequest() : void {
      dispatchEvent(new ForeignClanEvent(ForeignClanEvent.SEND_REQUEST));
    }

    public function acceptRequest() : void {
      dispatchEvent(new ForeignClanEvent(ForeignClanEvent.ACCEPT_REQUEST));
    }

    public function revokeRequest() : void {
      dispatchEvent(new ForeignClanEvent(ForeignClanEvent.REVOKE_REQUEST));
    }

    public function userSmallRankForAddClan() : void {
      this._foreignClanWindow.showAlertSmallRank();
    }

    public function onJoinClan(param1:String) : void {
      if(this._foreignClanWindow != null) {
        this._foreignClanWindow.joinClan(param1);
      }
    }

    public function alreadyInClanOutgoing() : void {
      if(this._foreignClanWindow != null) {
        this._foreignClanWindow.alreadyInClanOutgoing();
      }
    }

    public function alreadyInIncoming() : void {
      if(this._foreignClanWindow != null) {
        this._foreignClanWindow.alreadyInIncoming();
      }
    }

    public function clanBlocked(param1:String) : void {
      if(this._foreignClanWindow != null) {
        this._foreignClanWindow.clanBlocked(param1);
      }
    }

    public function destroyWindow() : void {
      this._foreignClanWindow.destroy();
    }

    public function resetWindow() : void {
      this._foreignClanWindow = null;
      this._isShowForeignClan = false;
    }

    public function isShowForeignClan() : Boolean {
      return this._isShowForeignClan;
    }
  }
}
