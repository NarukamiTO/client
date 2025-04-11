package alternativa.tanks.models.battle.gui.chat.cmdhandlers {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.models.battle.gui.chat.BattleChatOutput;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.blockuser.IBlockUserService;

  public class UnblockCommandHandler implements IChatCommandHandler {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var blockUserService:IBlockUserService;

    private var output:BattleChatOutput;

    public function UnblockCommandHandler(param1:BattleChatOutput) {
      super();
      this.output = param1;
    }

    public function handleCommand(param1:Array) : Boolean {
      if(param1.length == 0) {
        return false;
      }
      var local2:String = param1[0];
      blockUserService.unblockUser(local2);
      this.output.addSystemMessage(localeService.getText(TanksLocale.TEXT_CHAT_PANEL_COMMAND_UNBLOCK,local2));
      return true;
    }
  }
}
