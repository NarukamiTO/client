package alternativa.tanks.models.bonus.notification {
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.BattlefieldGUI;
  import alternativa.tanks.models.battle.gui.gui.statistics.messages.UserAction;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.bonus.randomgold.notification.IRandomGoldBonusTakeModelBase;
  import projects.tanks.client.battlefield.bonus.randomgold.notification.RandomGoldBonusTakeModelBase;

  [ModelInfo]
  public class RandomGoldBonusTakeModel extends RandomGoldBonusTakeModelBase implements IRandomGoldBonusTakeModelBase {
    public function RandomGoldBonusTakeModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function showBonusNotification(param1:String, param2:IGameObject, param3:String, param4:String) : void {
      var local5:ISpace = object.space;
      var local6:IGameObject = local5.rootObject;
      var local7:BattlefieldGUI = BattlefieldGUI(local6.adapt(BattlefieldGUI));
      local7.showBattleMessage(MessageColor.ORANGE,param3.replace(/%USERNAME%/g,param1));
      if(param2 != null) {
        local7.logUserAction(param2.id,UserAction.PLAYER_GOLD_BOX,null);
      }
    }
  }
}
