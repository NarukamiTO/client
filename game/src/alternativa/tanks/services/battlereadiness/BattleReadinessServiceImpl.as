package alternativa.tanks.services.battlereadiness {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.loader.ILoaderWindowService;
  import alternativa.tanks.loader.IModalLoaderService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class BattleReadinessServiceImpl implements BattleReadinessService {
    [Inject]
    public static var battleSerivce:BattleService;

    [Inject]
    public static var loaderWindowService:ILoaderWindowService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var modalLoaderService:IModalLoaderService;

    private var mapReady:Boolean;
    private var userReady:Boolean;

    public function BattleReadinessServiceImpl() {
      super();
    }

    public function reset() : void {
      lobbyLayoutService.setBattleReady(false);
      this.mapReady = false;
      this.userReady = false;
    }

    public function unlockMap() : void {
      if(!this.mapReady) {
        this.mapReady = true;
        this.tryToUnlock();
      }
    }

    public function unlockUser() : void {
      if(!this.userReady) {
        this.userReady = true;
        this.tryToUnlock();
      }
    }

    public function isBattleReady() : Boolean {
      return this.mapReady && this.userReady;
    }

    public function isMapReady() : Boolean {
      return this.mapReady;
    }

    private function tryToUnlock() : void {
      if(this.isBattleReady()) {
        lobbyLayoutService.setBattleReady(true);
        loaderWindowService.hide();
        modalLoaderService.hideForcibly();
        battleSerivce.unlockBattle();
      }
    }
  }
}
