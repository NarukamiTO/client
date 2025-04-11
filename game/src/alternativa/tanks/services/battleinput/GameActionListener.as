package alternativa.tanks.services.battleinput {
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;

  public interface GameActionListener {
    function onGameAction(param1:GameActionEnum, param2:Boolean) : void;
  }
}
