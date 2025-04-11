package alternativa.tanks.view.mainview.button {
  import alternativa.tanks.controllers.mainview.SwitchToBattleSelectEvent;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ShowBattleSelectButton extends MatchmakingButton {
    private static const battlesBtnClass:Class = ShowBattleSelectButton_battlesBtnClass;
    private static const battlesButton:Bitmap = new Bitmap(new battlesBtnClass().bitmapData);

    public function ShowBattleSelectButton(param1:int) {
      super(TanksLocale.TEXT_BATTLE_LIST_NAME,TanksLocale.TEXT_BATTLE_LIST_DESCRIPTION,battlesButton,null,param1);
      graphics.drawRect(0,0,0,frame.height + 2 * PADDING);
      button.setText(localeService.getText(TanksLocale.TEXT_OPEN_BATTLE_LIST_BUTTON));
    }

    override protected function onClick(param1:MouseEvent) : void {
      dispatchEvent(new SwitchToBattleSelectEvent());
    }

    override public function setSpectatorsButtonVisible(param1:Boolean) : void {
    }
  }
}
