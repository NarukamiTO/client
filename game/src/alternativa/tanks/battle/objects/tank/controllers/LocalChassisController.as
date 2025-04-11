package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.osgi.service.command.CommandService;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.tankchassis.TrackedChassis;
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import alternativa.tanks.services.battleinput.BattleInputService;
  import alternativa.tanks.services.battleinput.GameActionListener;
  import alternativa.tanks.utils.MathUtils;

  public class LocalChassisController extends ChassisController implements GameActionListener {
    [Inject]
    public static var commandService:CommandService;

    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleInputService:BattleInputService;

    private static const REVERSE_BACK_TURN_MASK:int = 1 << BIT_REVERSE_TURN;

    private var reverseBackTurnMask:int;
    private var cheatController:LocalCheatController;
    private var isEnabled:Boolean = false;

    public function LocalChassisController(param1:Tank, param2:ChassisControlListener) {
      super(param1,param2);
    }

    public function enable() : void {
      if(!this.isEnabled) {
        this.isEnabled = true;
        battleInputService.addGameActionListener(this);
      }
    }

    public function disable() : void {
      if(this.isEnabled) {
        this.isEnabled = false;
        battleInputService.removeGameActionListener(this);
        setControlState(0,TrackedChassis.TURN_SPEED_COUNT);
      }
    }

    public function onGameAction(param1:GameActionEnum, param2:Boolean) : void {
      var local4:int = 0;
      var local3:int = controlState;
      switch(param1) {
        case GameActionEnum.CHASSIS_FORWARD_MOVEMENT:
          local3 = MathUtils.changeBitValue(controlState,BIT_FORWARD,param2);
          break;
        case GameActionEnum.CHASSIS_BACKWARD_MOVEMENT:
          local3 = MathUtils.changeBitValue(controlState,BIT_BACK,param2);
          break;
        case GameActionEnum.CHASSIS_LEFT_MOVEMENT:
          local3 = MathUtils.changeBitValue(controlState,BIT_LEFT,param2);
          break;
        case GameActionEnum.CHASSIS_RIGHT_MOVEMENT:
          local3 = MathUtils.changeBitValue(controlState,BIT_RIGHT,param2);
      }
      if(local3 != controlState) {
        local4 = local3 | this.reverseBackTurnMask;
        setControlState(local4,TrackedChassis.TURN_SPEED_COUNT);
      }
    }

    override protected function onAppliedControlStateChanged(param1:int) : void {
      listener.onChassisControlChanged(param1,true);
    }

    public function setReversedBackTurn(param1:Boolean) : void {
      if(param1) {
        this.reverseBackTurnMask = REVERSE_BACK_TURN_MASK;
      } else {
        this.reverseBackTurnMask = 0;
        controlState &= ~REVERSE_BACK_TURN_MASK;
      }
    }

    [Obfuscation(rename="false")]
    override public function close() : void {
      super.close();
      this.disable();
    }

    private function enableCheatControls(param1:FormattedOutput) : void {
    }
  }
}
