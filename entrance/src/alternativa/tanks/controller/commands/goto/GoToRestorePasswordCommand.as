package alternativa.tanks.controller.commands.goto {
  import alternativa.tanks.controller.events.showform.ShowFormEvent;
  import org.robotlegs.mvcs.Command;

  public class GoToRestorePasswordCommand extends Command {
    public function GoToRestorePasswordCommand() {
      super();
    }

    override public function execute() : void {
      dispatch(new ShowFormEvent(ShowFormEvent.SHOW_RESTORE_PASSWORD_FORM));
    }
  }
}
