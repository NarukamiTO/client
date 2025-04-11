package alternativa.tanks.models.tank.spawn {
  import alternativa.tanks.battle.LogicUnit;
  import flash.utils.getTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class ReadyToPlaceTask implements LogicUnit {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private var tankObject:IGameObject;
    private var endTime:int;

    public function ReadyToPlaceTask(param1:int, param2:IGameObject) {
      super();
      this.tankObject = param2;
      this.endTime = getTimer() + param1;
    }

    public function runLogic(param1:int, param2:int) : void {
      if(this.tankObject && param1 >= this.endTime && !lobbyLayoutService.isWindowOpenOverBattle() && !lobbyLayoutService.isSwitchInProgress()) {
        ITankSpawner(this.tankObject.adapt(ITankSpawner)).setReadyToPlace();
      }
    }

    public function setTankObject(param1:IGameObject) : void {
      this.tankObject = param1;
    }
  }
}
