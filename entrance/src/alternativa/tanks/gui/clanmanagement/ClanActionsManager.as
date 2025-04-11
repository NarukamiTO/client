package alternativa.tanks.gui.clanmanagement {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.IClanActionListener;

  public class ClanActionsManager {
    private static var actionsUpdateListeners:Vector.<IClanActionListener> = new Vector.<IClanActionListener>();

    public function ClanActionsManager() {
      super();
    }

    public static function addActionsUpdateListener(param1:IClanActionListener) : void {
      var local2:int = int(actionsUpdateListeners.indexOf(param1));
      if(local2 < 0) {
        actionsUpdateListeners.push(param1);
      }
    }

    public static function removeActionsListener(param1:IClanActionListener) : void {
      var local2:int = int(actionsUpdateListeners.indexOf(param1));
      if(local2 >= 0) {
        actionsUpdateListeners.splice(local2,1);
      }
    }

    public static function updateActions() : void {
      var local1:IClanActionListener = null;
      for each(local1 in actionsUpdateListeners) {
        local1.updateActions();
      }
    }

    public static function removeListeners() : void {
      actionsUpdateListeners = new Vector.<IClanActionListener>();
    }
  }
}
