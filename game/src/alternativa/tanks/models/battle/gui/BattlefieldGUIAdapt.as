package alternativa.tanks.models.battle.gui {
  import alternativa.tanks.models.battle.gui.gui.statistics.field.Widget;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.DamageType;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattlefieldGUIAdapt implements BattlefieldGUI {
    private var object:IGameObject;
    private var impl:BattlefieldGUI;

    public function BattlefieldGUIAdapt(param1:IGameObject, param2:BattlefieldGUI) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function logUserAction(param1:Long, param2:UserAction, param3:Long) : void {
      var userId:Long = param1;
      var action:UserAction = param2;
      var targetUserId:Long = param3;
      try {
        Model.object = this.object;
        this.impl.logUserAction(userId,action,targetUserId);
      }
      finally {
        Model.popObject();
      }
    }

    public function setIndicatorState(param1:BattleTeam, param2:int) : void {
      var team:BattleTeam = param1;
      var newState:int = param2;
      try {
        Model.object = this.object;
        this.impl.setIndicatorState(team,newState);
      }
      finally {
        Model.popObject();
      }
    }

    public function setBothIndicatorsState(param1:int, param2:int) : void {
      var redState:int = param1;
      var blueState:int = param2;
      try {
        Model.object = this.object;
        this.impl.setBothIndicatorsState(redState,blueState);
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleMessage(param1:uint, param2:String) : void {
      var color:uint = param1;
      var text:String = param2;
      try {
        Model.object = this.object;
        this.impl.showBattleMessage(color,text);
      }
      finally {
        Model.popObject();
      }
    }

    public function showPointBattleLogMessage(param1:String, param2:UserAction) : void {
      var pointName:String = param1;
      var action:UserAction = param2;
      try {
        Model.object = this.object;
        this.impl.showPointBattleLogMessage(pointName,action);
      }
      finally {
        Model.popObject();
      }
    }

    public function showUserBattleLogMessage(param1:Long, param2:UserAction) : void {
      var userId:Long = param1;
      var action:UserAction = param2;
      try {
        Model.object = this.object;
        this.impl.showUserBattleLogMessage(userId,action);
      }
      finally {
        Model.popObject();
      }
    }

    public function showBattleLogMessage(param1:UserAction) : void {
      var action:UserAction = param1;
      try {
        Model.object = this.object;
        this.impl.showBattleLogMessage(action);
      }
      finally {
        Model.popObject();
      }
    }

    public function addWidget(param1:Widget) : void {
      var widget:Widget = param1;
      try {
        Model.object = this.object;
        this.impl.addWidget(widget);
      }
      finally {
        Model.popObject();
      }
    }

    public function logKillAction(param1:Long, param2:Long, param3:DamageType) : void {
      var killerId:Long = param1;
      var targetUserId:Long = param2;
      var damageType:DamageType = param3;
      try {
        Model.object = this.object;
        this.impl.logKillAction(killerId,targetUserId,damageType);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
