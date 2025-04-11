package projects.tanks.clients.flash.commons.models.layout.notify {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.layout.LayoutState;

  public class ILobbyLayoutNotifyAdapt implements ILobbyLayoutNotify {
    private var object:IGameObject;
    private var impl:ILobbyLayoutNotify;

    public function ILobbyLayoutNotifyAdapt(param1:IGameObject, param2:ILobbyLayoutNotify) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function layoutSwitchPredicted() : void {
      try {
        Model.object = this.object;
        this.impl.layoutSwitchPredicted();
      }
      finally {
        Model.popObject();
      }
    }

    public function isSwitchInProgress() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isSwitchInProgress());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCurrentState() : LayoutState {
      var result:LayoutState = null;
      try {
        Model.object = this.object;
        result = this.impl.getCurrentState();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function inBattle() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.inBattle());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
