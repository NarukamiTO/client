package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.physics.Body;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.cheatsemulation.ZCoordinateFreezer;
  import flash.events.KeyboardEvent;
  import flash.utils.Dictionary;

  public class LocalCheatController {
    [Inject]
    public static var display:IDisplay;

    [Inject]
    public static var battleService:BattleService;

    private static const MOVEMENT_DISTANCE:Number = 10;

    private var tank:Tank;

    private const keyHandlers:Dictionary = new Dictionary();

    private var zCoordinateFreezer:ZCoordinateFreezer;
    private var JUMP_VELOCITY:ConsoleVarFloat = new ConsoleVarFloat("jump_velocity",300,0,2000);

    public function LocalCheatController(param1:Tank) {
      super();
    }

    private function onKey(param1:KeyboardEvent) : void {
    }

    private function setHandler(param1:uint, param2:Function) : void {
    }

    public function destroy() : void {
    }

    private function getBody() : Body {
      return null;
    }

    private function onKeyDisablePhysics(param1:Boolean) : void {
    }

    private function resetOrientation(param1:Boolean) : void {
    }

    private function moveLeft(param1:Boolean) : void {
    }

    private function moveRight(param1:Boolean) : void {
    }

    private function moveForward(param1:Boolean) : void {
    }

    private function moveBack(param1:Boolean) : void {
    }

    private function moveUp(param1:Boolean) : void {
    }

    private function moveDown(param1:Boolean) : void {
    }

    private function move(param1:Number, param2:Number, param3:Number) : void {
    }

    private function toggleZCoordinateFreeze(param1:Boolean) : void {
    }

    private function cheatJump(param1:Boolean) : void {
    }

    private function cheatStrafeLeft(param1:Boolean) : void {
    }

    private function cheatStrafeRight(param1:Boolean) : void {
    }

    private function accelerate(param1:Number, param2:Number, param3:Number) : void {
    }
  }
}
