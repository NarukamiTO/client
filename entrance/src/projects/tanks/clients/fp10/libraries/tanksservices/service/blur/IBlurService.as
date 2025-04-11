package projects.tanks.clients.fp10.libraries.tanksservices.service.blur {
  import flash.display.DisplayObject;
  import flash.events.IEventDispatcher;

  public interface IBlurService extends IEventDispatcher {
    function blurBattleContent() : void;
    function unblurBattleContent() : void;
    function blurGameContent() : void;
    function unblurGameContent() : void;
    function blurDialogContent() : void;
    function unblurDialogContent() : void;
    function blurAllContent() : void;
    function unblurAllContent() : void;
    function blurComponent(param1:DisplayObject) : void;
    function unblurComponent(param1:DisplayObject) : void;
    function unblurAllComponents() : void;
  }
}
