package projects.tanks.clients.flash.commons.models.layout {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.layout.LayoutState;

  public class ILobbyLayoutAdapt implements ILobbyLayout {
    private var object:IGameObject;
    private var impl:ILobbyLayout;

    public function ILobbyLayoutAdapt(param1:IGameObject, param2:ILobbyLayout) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showGarage() : void {
      try {
        Model.object = this.object;
        this.impl.showGarage();
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleSelect() : void {
      try {
        Model.object = this.object;
        this.impl.showBattleSelect();
      }
      finally {
        Model.popObject();
      }
    }

    public function showMatchmaking() : void {
      try {
        Model.object = this.object;
        this.impl.showMatchmaking();
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleLobby() : void {
      try {
        Model.object = this.object;
        this.impl.showBattleLobby();
      }
      finally {
        Model.popObject();
      }
    }

    public function showClan() : void {
      try {
        Model.object = this.object;
        this.impl.showClan();
      }
      finally {
        Model.popObject();
      }
    }

    public function exitFromBattle() : void {
      try {
        Model.object = this.object;
        this.impl.exitFromBattle();
      }
      finally {
        Model.popObject();
      }
    }

    public function exitFromBattleToState(param1:LayoutState) : void {
      var state:LayoutState = param1;
      try {
        Model.object = this.object;
        this.impl.exitFromBattleToState(state);
      }
      finally {
        Model.popObject();
      }
    }

    public function returnToBattle() : void {
      try {
        Model.object = this.object;
        this.impl.returnToBattle();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
