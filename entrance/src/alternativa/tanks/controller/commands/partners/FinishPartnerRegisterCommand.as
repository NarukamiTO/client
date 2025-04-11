package alternativa.tanks.controller.commands.partners {
  import alternativa.tanks.controller.events.partners.FinishPartnerRegisterEvent;
  import alternativa.tanks.model.EntranceUrlParamsModel;
  import alternativa.tanks.service.IEntranceServerFacade;
  import org.robotlegs.mvcs.Command;

  public class FinishPartnerRegisterCommand extends Command {
    [Inject]
    public var event:FinishPartnerRegisterEvent;

    [Inject]
    public var urlParams:EntranceUrlParamsModel;

    [Inject]
    public var serverFacade:IEntranceServerFacade;

    public function FinishPartnerRegisterCommand() {
      super();
    }

    override public function execute() : void {
      this.serverFacade.finishPartnerRegistration(this.event.uid,this.urlParams.domain);
    }
  }
}
