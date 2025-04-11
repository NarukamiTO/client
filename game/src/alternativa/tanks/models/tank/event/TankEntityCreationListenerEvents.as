package alternativa.tanks.models.tank.event {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.tank.TankLogicState;

  public class TankEntityCreationListenerEvents implements TankEntityCreationListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TankEntityCreationListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onTankEntityCreated(param1:Tank, param2:Boolean, param3:TankLogicState) : void {
      var i:int = 0;
      var m:TankEntityCreationListener = null;
      var tank:Tank = param1;
      var isLocal:Boolean = param2;
      var logicState:TankLogicState = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankEntityCreationListener(this.impl[i]);
          m.onTankEntityCreated(tank,isLocal,logicState);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
