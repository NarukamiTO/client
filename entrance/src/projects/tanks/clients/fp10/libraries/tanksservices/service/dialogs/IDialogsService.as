package projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs {
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public interface IDialogsService {
    function addDialog(param1:DialogWindow) : void;
    function enqueueDialog(param1:DialogWindow) : void;
    function removeDialog(param1:DialogWindow) : void;
    function centerDialog(param1:DialogWindow) : void;
  }
}
