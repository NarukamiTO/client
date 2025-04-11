package projects.tanks.clients.fp10.libraries.tanksservices.service.address {
  import alternativa.osgi.OSGi;
  import alternativa.types.Long;
  import flash.events.EventDispatcher;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.service.address.AddressService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.events.BattleChangedAddressEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.address.events.TanksAddressEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.servername.ServerNumberToLocaleServerService;
  import projects.tanks.clients.fp10.libraries.tanksservices.utils.BattleInfoUtils;
  import swfaddress.SWFAddressEvent;

  public class TanksAddressServiceImpl extends EventDispatcher implements TanksAddressService {
    [Inject]
    public static var serverNameService:ServerNumberToLocaleServerService;

    [Inject]
    public static var addressService:AddressService;

    private const DELAY_LISTEN_ADDRESS_CHANGE:int = 1500;

    private var currentValue:String;
    private var serverName:int;
    private var oldServerName:int;
    private var battleId:Long;
    private var _locked:Boolean = true;
    private var timeoutId:uint;

    public function TanksAddressServiceImpl() {
      super();
      var local1:String = AddressService(OSGi.getInstance().getService(AddressService)).getValue();
      this.battleId = this.parseBattle(local1);
    }

    public function hasBattle() : Boolean {
      return this.battleId != null;
    }

    public function getBattleId() : Long {
      return this.battleId;
    }

    public function init(param1:int) : void {
      this.oldServerName = this.serverName = param1;
      this.locked = false;
    }

    public function back() : void {
      this.serverName = this.oldServerName;
      dispatchEvent(new TanksAddressEvent(TanksAddressEvent.BACK));
      this.locked = false;
    }

    public function getServerNumber() : int {
      return this.serverName;
    }

    public function setServer(param1:int) : void {
      if(this.locked) {
        return;
      }
      this.setServerByNameAndBattle(param1,null);
      this.setParams();
    }

    private function setServerByNameAndBattle(param1:int, param2:Long) : void {
      if(this.serverName == param1) {
        this.setBattle(param2);
        return;
      }
      this.serverName = param1;
      this.battleId = param2;
      this.locked = true;
      dispatchEvent(new TanksAddressEvent(TanksAddressEvent.TRY_CHANGE_SERVER));
    }

    public function setBattle(param1:Long) : void {
      if(this.locked) {
        return;
      }
      if(this.battleId == param1) {
        return;
      }
      this.battleId = param1;
      dispatchEvent(new BattleChangedAddressEvent(param1));
      this.setParams();
    }

    public function resetBattle() : void {
      if(this.locked) {
        return;
      }
      this.battleId = null;
      dispatchEvent(new TanksAddressEvent(TanksAddressEvent.BATTLE_RESET));
      this.setParams();
    }

    private function onAddressChange(param1:SWFAddressEvent) : void {
      if(this.locked) {
        return;
      }
      this.setServerByNameAndBattle(this.serverName,this.parseBattle(param1.value));
    }

    private function setParams() : void {
      var local1:String = "";
      if(this.battleId != null) {
        local1 += "battle=" + BattleInfoUtils.getBattleIdUhex(this.battleId);
      }
      addressService.setValue(local1,false);
      this.currentValue = local1;
    }

    public function parseBattle(param1:String) : Long {
      var local2:int = int(param1.indexOf("battle="));
      if(local2 != -1) {
        return Long.fromHexString(param1.substr(local2 + 7,16));
      }
      return null;
    }

    public function get locked() : Boolean {
      return this._locked;
    }

    public function set locked(param1:Boolean) : void {
      if(this._locked == param1) {
        return;
      }
      if(param1) {
        this.lock();
      } else {
        this.unlock();
      }
    }

    private function lock() : void {
      this._locked = true;
      addressService.removeEventListener(SWFAddressEvent.CHANGE,this.onAddressChange);
      clearTimeout(this.timeoutId);
    }

    private function unlock() : void {
      this._locked = false;
      this.timeoutId = setTimeout(this.listenAddressChange,this.DELAY_LISTEN_ADDRESS_CHANGE);
    }

    private function listenAddressChange() : void {
      addressService.addEventListener(SWFAddressEvent.CHANGE,this.onAddressChange);
      var local1:SWFAddressEvent = new SWFAddressEvent(SWFAddressEvent.CHANGE);
      this.onAddressChange(local1);
    }
  }
}
