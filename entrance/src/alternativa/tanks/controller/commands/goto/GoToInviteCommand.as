package alternativa.tanks.controller.commands.goto {
  import alternativa.tanks.controller.events.showform.ShowFormEvent;
  import org.robotlegs.mvcs.Command;

  public class GoToInviteCommand extends Command {
    public function GoToInviteCommand() {
      super();
    }

    override public function execute() : void {
      dispatch(new ShowFormEvent(ShowFormEvent.SHOW_INVITE_FORM));
    }
  }
}
