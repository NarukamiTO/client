package alternativa.tanks.model.rulesupdate {
  import alternativa.tanks.gui.RulesUpdateAlert;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.rulesupdate.showing.IRulesUpdateShowingModelBase;
  import projects.tanks.client.panel.model.rulesupdate.showing.RulesUpdateShowingModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.IDialogsService;

  [ModelInfo]
  public class RulesUpdateShowingModel extends RulesUpdateShowingModelBase implements IRulesUpdateShowingModelBase, ObjectLoadListener {
    [Inject]
    public static var dialogService:IDialogsService;

    private var alert:RulesUpdateAlert;

    public function RulesUpdateShowingModel() {
      super();
    }

    public function objectLoaded() : void {
      if(getInitParam().showAcceptRulesAlert) {
        this.alert = new RulesUpdateAlert(getInitParam().topText,getInitParam().bottomText,getFunctionWrapper(this.onRulesAccept));
        dialogService.addDialog(this.alert);
      }
    }

    private function onRulesAccept() : void {
      dialogService.removeDialog(this.alert);
      server.userAcceptedRules();
    }
  }
}
