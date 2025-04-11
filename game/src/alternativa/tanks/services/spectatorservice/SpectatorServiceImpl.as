package alternativa.tanks.services.spectatorservice {
  public class SpectatorServiceImpl implements SpectatorService {
    private var userTitlesVisible:Boolean;

    public function SpectatorServiceImpl() {
      super();
    }

    public function getUserTitlesVisible() : Boolean {
      return this.userTitlesVisible;
    }

    public function setUserTitlesVisible(param1:Boolean) : void {
      this.userTitlesVisible = param1;
    }
  }
}
