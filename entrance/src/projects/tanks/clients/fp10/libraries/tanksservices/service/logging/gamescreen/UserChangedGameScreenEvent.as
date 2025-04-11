package projects.tanks.clients.fp10.libraries.tanksservices.service.logging.gamescreen {
  import flash.events.Event;
  import projects.tanks.client.tanksservices.model.logging.gamescreen.GameScreen;

  public class UserChangedGameScreenEvent extends Event {
    public static const TYPE:String = "UserChangedGameScreenEvent";

    private var _previousScreen:GameScreen;
    private var _newScreen:GameScreen;

    public function UserChangedGameScreenEvent(param1:GameScreen, param2:GameScreen) {
      this._previousScreen = param1;
      this._newScreen = param2;
      super(TYPE);
    }

    public function getPreviousScreen() : GameScreen {
      return this._previousScreen;
    }

    public function getNewScreen() : GameScreen {
      return this._newScreen;
    }
  }
}
