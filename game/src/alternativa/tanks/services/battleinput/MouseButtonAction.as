package alternativa.tanks.services.battleinput {
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;

  public class MouseButtonAction {
    public var isActive:Boolean = false;

    private var _gameAction:GameActionEnum;

    public function MouseButtonAction(param1:GameActionEnum) {
      super();
      this._gameAction = param1;
    }

    public function get gameAction() : GameActionEnum {
      return this._gameAction;
    }
  }
}
