package projects.tanks.clients.fp10.libraries.tanksservices.service.battle {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import projects.tanks.client.battleservice.BattleRoundParameters;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.TanksAddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;

  public class BattleInfoService extends EventDispatcher implements IBattleInfoService {
    [Inject]
    public static var addressService:TanksAddressService;

    [Inject]
    public static var serverNameService:ServerNumberToLocaleServerService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private var _currentBattleId:Long;
    private var _currentSelectionBattleId:Long;
    private var _minRank:int;
    private var _maxRank:int;
    private var _spectatorMode:Boolean;
    private var _reArmorEnabled:Boolean;
    private var _enterGarageCausesExitBattle:Boolean = false;
    private var _withoutSupplies:Boolean;
    private var _withoutBonuses:Boolean;
    private var _withoutDrones:Boolean;
    private var _running:Boolean;
    private var userIsInBattle:Boolean;

    public function BattleInfoService() {
      super();
    }

    public function get currentSelectionBattleId() : Long {
      return this._currentSelectionBattleId;
    }

    public function setCurrentSelectionBattleAndNotify(param1:Long, param2:int, param3:int) : void {
      this.setBattleData(param1,param2,param3);
      addressService.setBattle(param1);
      dispatchEvent(new BattleInfoServiceEvent(BattleInfoServiceEvent.SELECTION_BATTLE));
    }

    private function setBattleData(param1:Long, param2:int, param3:int) : void {
      this._currentSelectionBattleId = param1;
      this._minRank = param2;
      this._maxRank = param3;
    }

    public function setCurrentSelectionBattle(param1:Long, param2:int, param3:int) : void {
      this.setBattleData(param1,param2,param3);
      addressService.setBattle(param1);
    }

    public function get currentBattleId() : Long {
      return this._currentBattleId;
    }

    public function set currentBattleId(param1:Long) : void {
      this._currentBattleId = param1;
      addressService.setBattle(param1);
    }

    public function resetCurrentBattle() : void {
      this._spectatorMode = false;
      this._currentBattleId = null;
      if(this._currentSelectionBattleId != null) {
        addressService.setBattle(this._currentSelectionBattleId);
      } else {
        addressService.resetBattle();
      }
      dispatchEvent(new BattleInfoServiceEvent(BattleInfoServiceEvent.BATTLE_UNLOAD));
    }

    public function resetCurrentSelectionBattleId() : void {
      if(this._currentBattleId == this._currentSelectionBattleId) {
        this._currentSelectionBattleId = null;
        if(Boolean(serverNameService) && Boolean(serverNameService.isLocalServer())) {
          addressService.resetBattle();
          dispatchEvent(new BattleInfoServiceEvent(BattleInfoServiceEvent.RESET_SELECTION_BATTLE));
        }
      }
    }

    public function hasCurrentSelectionBattleId() : Boolean {
      return this._currentSelectionBattleId != null;
    }

    public function hasCurrentBattleId() : Boolean {
      return this._currentBattleId != null;
    }

    public function isSpectatorMode() : Boolean {
      return this._spectatorMode;
    }

    public function set spectatorMode(param1:Boolean) : void {
      this._spectatorMode = param1;
    }

    public function get reArmorEnabled() : Boolean {
      return this._reArmorEnabled;
    }

    public function set reArmorEnabled(param1:Boolean) : void {
      this._reArmorEnabled = param1;
    }

    public function availableRank(param1:int) : Boolean {
      if(this.hasCurrentSelectionBattleId()) {
        return param1 >= this._minRank && param1 <= this._maxRank;
      }
      return false;
    }

    public function isAvailableSelectionBattle() : Boolean {
      return this.availableRank(userPropertiesService.rank);
    }

    public function restoreCurrentBattleIdInAddressService() : void {
      if(this.hasCurrentBattleId()) {
        addressService.setBattle(this.currentBattleId);
      }
    }

    public function battleRestart() : void {
      dispatchEvent(new BattleInfoServiceEvent(BattleInfoServiceEvent.BATTLE_RESTART));
    }

    public function battleLoad() : void {
      dispatchEvent(new BattleInfoServiceEvent(BattleInfoServiceEvent.BATTLE_LOAD));
    }

    public function get withoutSupplies() : Boolean {
      return this._withoutSupplies;
    }

    public function set withoutSupplies(param1:Boolean) : void {
      this._withoutSupplies = param1;
    }

    public function get withoutBonuses() : Boolean {
      return this._withoutBonuses;
    }

    public function get withoutDrones() : Boolean {
      return this._withoutDrones;
    }

    public function set withoutBonuses(param1:Boolean) : void {
      this._withoutBonuses = param1;
    }

    public function set withoutDrones(param1:Boolean) : void {
      this._withoutDrones = param1;
    }

    public function battleStart(param1:BattleRoundParameters) : void {
      this._reArmorEnabled = param1.reArmorEnabled;
      dispatchEvent(new BattleInfoServiceEvent(BattleInfoServiceEvent.BATTLE_START));
    }

    public function forceResetCurrentSelectionBattleId() : void {
      this._currentSelectionBattleId = null;
    }

    public function get running() : Boolean {
      return this._running;
    }

    public function set running(param1:Boolean) : void {
      this._running = param1;
    }

    public function isInBattle() : Boolean {
      return this.userIsInBattle;
    }

    public function setInBattle(param1:Boolean) : void {
      this.userIsInBattle = param1;
    }

    public function get enterGarageCausesExitBattle() : Boolean {
      return this._enterGarageCausesExitBattle;
    }

    public function set enterGarageCausesExitBattle(param1:Boolean) : void {
      this._enterGarageCausesExitBattle = param1;
    }
  }
}
