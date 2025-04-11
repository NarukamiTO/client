package alternativa.tanks.battle.scene3d {
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.tanks.battle.BattleService;

  public class BattleScene3DDebugCommands {
    [Inject]
    public static var battleService:BattleService;

    public function BattleScene3DDebugCommands() {
      super();
    }

    private function makeBox(param1:FormattedOutput, param2:Number, param3:uint, param4:Number, param5:Number, param6:Number) : void {
    }

    public function destroy() : void {
    }
  }
}
