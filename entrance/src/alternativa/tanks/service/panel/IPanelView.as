package alternativa.tanks.service.panel {
  import alternativa.tanks.gui.panel.MainPanel;
  import flash.events.IEventDispatcher;

  public interface IPanelView extends IEventDispatcher {
    function setPanel() : void;
    function getPanel() : MainPanel;
    function lock() : void;
    function unlock() : void;
    function showAlert(param1:String) : void;
  }
}
