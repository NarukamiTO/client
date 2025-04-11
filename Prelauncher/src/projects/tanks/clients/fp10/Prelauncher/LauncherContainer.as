package projects.tanks.clients.fp10.Prelauncher {
  import flash.display.DisplayObject;
  import flash.display.Sprite;

  public class LauncherContainer extends Sprite {
    private var prelauncher:Prelauncher;

    public function LauncherContainer(tanksLauncher:DisplayObject, prelauncher:Prelauncher) {
      super();
      this.prelauncher = prelauncher;
      addChild(tanksLauncher);
    }

    public function isUserFromTutorial() : Boolean {
      return this.prelauncher.isUserFromTutorial();
    }

    public function closeLauncher() : void {
      this.prelauncher.closeLauncher();
    }

    public function get serverStored() : Boolean {
      return this.prelauncher.serverStored;
    }
  }
}
