package projects.tanks.clients.flash.commons.models.layout.notify {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.layout.LayoutState;

  public class ILobbyLayoutNotifyEvents implements ILobbyLayoutNotify {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ILobbyLayoutNotifyEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function layoutSwitchPredicted() : void {
      var i:int = 0;
      var m:ILobbyLayoutNotify = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayoutNotify(this.impl[i]);
          m.layoutSwitchPredicted();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function isSwitchInProgress() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ILobbyLayoutNotify = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayoutNotify(this.impl[i]);
          result = Boolean(m.isSwitchInProgress());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCurrentState() : LayoutState {
      var result:LayoutState = null;
      var i:int = 0;
      var m:ILobbyLayoutNotify = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayoutNotify(this.impl[i]);
          result = m.getCurrentState();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function inBattle() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ILobbyLayoutNotify = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayoutNotify(this.impl[i]);
          result = Boolean(m.inBattle());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
