package projects.tanks.clients.fp10.TanksLauncherErrorScreen {
  import flash.events.IEventDispatcher;

  public interface ITanksErrorMessage extends IEventDispatcher {
    function init(errorCode:String, isTestServer:Boolean, anotherGameServerUrl:String, locale:String) : void;
    function redraw(stageWidth:int, stageHeight:int) : void;
  }
}
