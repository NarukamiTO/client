package alternativa.tanks.controllers.mathmacking {
  import alternativa.tanks.service.battlelist.MatchmakingEvent;
  import alternativa.tanks.view.matchmaking.MatchmakingRegistrationDialog;
  import flash.events.EventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;

  public class MatchmakingFormController extends EventDispatcher {
    [Inject]
    public static var dialogService:IDialogsService;

    private var view:MatchmakingRegistrationDialog;

    public function MatchmakingFormController() {
      super();
    }

    public function showForm(param1:String, param2:int) : void {
      if(this.view == null) {
        this.view = new MatchmakingRegistrationDialog();
      }
      this.view.addEventListener(MatchmakingEvent.UNREGISTRATION,this.onUnregister);
      this.view.prepareForShowing(param1,param2);
      dialogService.addDialog(this.view);
    }

    public function hideForm() : void {
      if(this.view == null) {
        return;
      }
      this.view.removeEventListener(MatchmakingEvent.UNREGISTRATION,this.onUnregister);
      this.view.prepareForHiding();
      dialogService.removeDialog(this.view);
    }

    private function onUnregister(param1:MatchmakingEvent) : void {
      dispatchEvent(new MatchmakingEvent(MatchmakingEvent.UNREGISTRATION));
    }
  }
}
