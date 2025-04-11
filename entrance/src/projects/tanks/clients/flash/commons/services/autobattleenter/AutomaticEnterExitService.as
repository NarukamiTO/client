package projects.tanks.clients.flash.commons.services.autobattleenter {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.osgi.service.logging.LogService;
  import flash.events.EventDispatcher;
  import projects.tanks.client.commons.models.layout.LayoutState;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.flash.commons.services.payment.PaymentDisplayService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class AutomaticEnterExitService extends EventDispatcher {
    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    [Inject]
    public static var logService:LogService;

    [Inject]
    public static var paymentDisplayService:PaymentDisplayService;

    private var enabledBattle:Boolean;
    private var enabledGarage:Boolean;
    private var enabledPayment:Boolean;
    private var joinAsSpectator:Boolean;
    private var countEntrance:int;
    private var maxEntrance:int;
    private var memoryGraph:Vector.<Number> = new Vector.<Number>();

    public function AutomaticEnterExitService(param1:OSGi) {
      super();
    }

    private function onEndLayoutSwitch(param1:LobbyLayoutServiceEvent) : void {
    }

    private function switchGarage(param1:LayoutState) : void {
    }

    private function _enableForPayment(param1:FormattedOutput, param2:int) : void {
    }

    private function _enableForGarage(param1:FormattedOutput, param2:int) : void {
    }

    private function _enableForSpectator(param1:FormattedOutput, param2:int) : void {
    }

    private function _enableForRegularUser(param1:FormattedOutput, param2:int) : void {
    }

    private function _enableBattle(param1:Boolean, param2:int) : void {
    }

    private function _disable(param1:FormattedOutput) : void {
    }

    private function _traceMemoryGraph(param1:FormattedOutput) : void {
    }

    public function onBattleInfoLoaded() : void {
    }

    private function saveMemory() : void {
    }

    public function onBattleLoaded() : void {
    }
  }
}
