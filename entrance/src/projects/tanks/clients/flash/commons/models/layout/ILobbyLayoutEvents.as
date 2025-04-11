package projects.tanks.clients.flash.commons.models.layout {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.models.layout.LayoutState;

  public class ILobbyLayoutEvents implements ILobbyLayout {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ILobbyLayoutEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showGarage() : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.showGarage();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleSelect() : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.showBattleSelect();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showMatchmaking() : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.showMatchmaking();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleLobby() : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.showBattleLobby();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showClan() : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.showClan();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function exitFromBattle() : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.exitFromBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function exitFromBattleToState(param1:LayoutState) : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      var state:LayoutState = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.exitFromBattleToState(state);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function returnToBattle() : void {
      var i:int = 0;
      var m:ILobbyLayout = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILobbyLayout(this.impl[i]);
          m.returnToBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
