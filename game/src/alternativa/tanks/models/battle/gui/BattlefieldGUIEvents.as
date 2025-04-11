package alternativa.tanks.models.battle.gui {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattlefieldGUIEvents implements BattlefieldGUI {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattlefieldGUIEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function logUserAction(param1:Long, param2:UserAction, param3:Long) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var userId:Long = param1;
      var action:UserAction = param2;
      var targetUserId:Long = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.logUserAction(userId,action,targetUserId);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setIndicatorState(param1:BattleTeam, param2:int) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var team:BattleTeam = param1;
      var newState:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.setIndicatorState(team,newState);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setBothIndicatorsState(param1:int, param2:int) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var redState:int = param1;
      var blueState:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.setBothIndicatorsState(redState,blueState);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleMessage(param1:uint, param2:String) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var color:uint = param1;
      var text:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.showBattleMessage(color,text);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showPointBattleLogMessage(param1:String, param2:UserAction) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var pointName:String = param1;
      var action:UserAction = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.showPointBattleLogMessage(pointName,action);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showUserBattleLogMessage(param1:Long, param2:UserAction) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var userId:Long = param1;
      var action:UserAction = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.showUserBattleLogMessage(userId,action);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleLogMessage(param1:UserAction) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var action:UserAction = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.showBattleLogMessage(action);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function addWidget(param1:Widget) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var widget:Widget = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.addWidget(widget);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function logKillAction(param1:Long, param2:Long, param3:DamageType) : void {
      var i:int = 0;
      var m:BattlefieldGUI = null;
      var killerId:Long = param1;
      var targetUserId:Long = param2;
      var damageType:DamageType = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldGUI(this.impl[i]);
          m.logKillAction(killerId,targetUserId,damageType);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
